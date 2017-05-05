trushal = User.create(username: "Trushal", email:"t@trushal.com", password: "password")
hima = User.create(username: "Hima", email:"h@hima.com", password: "password2")

ruby = Language.create(name: "Ruby")
html = Language.create(name: "HTML")
css = Language.create(name: "CSS")

tip1 = trushal.tips.build(content: "Array#*, when supplied with a number, multiplies the size of the array by using duplicate elements: [1, 2, 3] * 3 == [1, 2, 3, 1, 2, 3, 1, 2, 3]")
tip1.language = ruby
tip1.save

tip2 = trushal.tips.build(content: "Instead of defining a local variable with some initial content (often just an empty hash or array), you can instead define it 'on the go' so you can perform operations on it at the same time: (z ||= []) << 'test'")
tip2.language = ruby
tip2.save

tip3 = hima.tips.build(content: "Rubyists are often keen to remove repetition - often espousing 'DRY' (Don't Repeat Yourself). You can take this to extremes using Ruby's enumerators to perform similar operations multiple times. Consider requiring multiple files, for instance: %w{rubygems daemons eventmachine}.each { |x| require x }")
tip3.language = ruby
tip3.save

tip4 = hima.tips.build(content: "Always declare margin and padding in block-level elements.")
tip4.language = css
tip4.save

tip5 = hima.tips.build(content: "After you have a design, start with a blank page of content. “Include your headers, your navigation, a sample of the content, and your footer. Then start adding your html markup. Then start adding your CSS. It works out much better.")
tip5.language = css
tip5.save
