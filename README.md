# BlinkTest
Coding Test for Blink

What works:
- The App currently loads conversations from a JSON and displays them in date order (oldest conversations / messages at the top)
- When entering a conversation a User can add a message to the conversation - which will update the messages and the order of the conversations on the conversations list screen

What I would have added with more time:
- ViewModel Stubs to use in the previews for the Views
- Adding in a Protocol for the Manager and thus also a Stub / Mock
- The textfield could use better placement and multilined input (or if still single line allow the return button to mirror what the send button does)
- The ability to save the new messages back to the JSON
- Unit tests for the ViewModels
- If an error happens when trying to add a new message to a conversation, display this to the User (instead of the current print)
- When adding a new message, scroll to the bottom of the message list
