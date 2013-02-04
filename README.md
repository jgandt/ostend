# We All Have Hashes

#### And at some point we just want to:
```ruby
hash = { :name => 'Twilight Sparkle', :enemy => 'Ahuizotl', :size => 'little' }

my_correctly_sized_pony = SizedPony.new(hash)

my_correctly_sized_pony.name
  # => 'Twilight Sparkle'
  
my_correctly_sized_pony.enemy = 'Queen Chrysalis'
  # => 'Queen Chrysalis'
```

We can use OpenStruct, but then we can't directly inherit from the real class!

### Why in Ponyland is that so hard?

# It's Not Hard

```ruby
class SizedPony < Pony
  include Ostend
  
  def initialize(hash)
    ostendify(hash)
  end
end
```

Two new lines. That's it! And nothing is forced on you.

If you don't want to instantiate the variables in new(), you don't have to. You can call ostendify() anywhere you like.

## There's Always More

I have added a few additional features:
#### Accessor Type control

Be default, Ostend creates attr_accessors.

You say you'd prefer writers (or readers)? Set @ostend_attr_type before you call ostendify()
```ruby
  pony.ostend_attr_type = :writer # or = :reader
  pony.ostendify( hash )
  
  pony.size
    # => NoMethodError
```

#### Attribute Filter

Whitelist hash keys for attributes that you don't want assigned
You don't want your ponies to have enemies? Set @ostend_attr_filter before you call ostendify()

```ruby
  pony.ostend_attr_filter = [:name, :size]
  # Now Ostend happily and silenty drops the other hash keys
  pony.ostendify( hash )
  
  pony.enemy
    # => NoMethodError
```

#### Strict Assignment

Lastly, you can force exceptions if you don't want arguments other that what you specified in the filter.

```ruby
  pony.ostend_attr_filter = [:name, :size]
  pony.ostend_strict      = true
  # Now Ostend throws a hissy fit when you attempt instantiaion
  
  pony.ostendify( hash )
    # => Exception :: The following are not allowed attributes: :enemies
```

### Still More
Combine this with ActiveRecord validations, and you can do some awesome stuff.

There are other gem combinations that could be really killer.

Let Me Know What You Discover!

## Reasoning

#### Ostend is meant to be a simple, Unix-like tool that doesn't get in your way. It helps you maintain your sanity and SRP.

###### But you can just use OpenStruct as your parent.
**Sure but then you can't inherit from what the class you really should be inheriting from.**

###### But you can create an abstraction layer between OpenStruct and your class
**Yup! Except this is easier and cleaner (imo).**

Using this as a mix in we are able to maintain a meaningful class structure while exposing the hash keys as viable and visable methods.
This helps to keep your Classes focused on what they need to do. They don't run around, crazily setting

The accessors are also created on each individual instance of your class. In this way, you can have object of the same class with different configurations.

Keep in mind, there are awesome gems like Virtus [solnic/virtus](https://github.com/solnic/virtus) that can enable a bunch of what I do here.

However, Virtus requires full attribute definition as part of it's explicit goal.

## Where Is This Going
I have a few ideas for expansion.

1) Enabling class level accessor creation
2) Create the Ostend variable as class_level variables to allow easier control over the entire class
3) I could start to get into crazy, ActiveRecord relation assignments

However, I'm not sure how far I will go as it's current form is just about the size I want it to be.

Thoughts? Comments? Is their an easier, clearer way (ActiveModel if working in rails)?

.jpg
