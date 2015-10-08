Vurb Take Home Problem
Maxwell Elliott
========================

Questions:

1) How does your implementation handle adding 20 more types?

For those additional types you would simply need to subclass MLEVurbCardView and add your type to the CardData model and the card view generation logic inside MLEVurbCardViewFactory.

2) How portable is your card implementation (implementing in other view controllers)?

Very portable, the card view is completly encapsulated and does not have any references to its parent. Users of the card view who want to consume it should implement the MLEVurbCardContainerViewProtocol to do view managment of the card view. The MLEVurbCardViewFactory class can generate card views anywhere in the app. Also the MLEVurbCardDataManager can be used to fetch card data anywhere in the app

3) How long did this exercise take you? (Length of time spent does not indicate anything
to us about your proficiency. We just want to make sure the exercise takes a reasonable amount of time).

6 Hours? I think?