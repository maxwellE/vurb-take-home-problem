Vurb Take Home Problem
Maxwell Elliott
========================

Questions:

1) How does your implementation handle adding 20 more types?

For those additional types you would simply need to subclass MLEVurbCardView and add your type to the CardData model and the card view generation logic inside MLEVurbCardViewFactory.

2) How portable is your card implementation (implementing in other view controllers)?

Very portable, the card view is completly encapsulated and does not have any references to its parent. Each card view can be created anywhere in the app and it not tied to the table view.

3) How long did this exercise take you? (Length of time spent does not indicate anything
to us about your proficiency. We just want to make sure the exercise takes a reasonable amount of time).

8 Hours? I think?