# flutter_mvvm

An example of implementing a flutter MVVM application using two simple base classes for
`StatefulWidget`s and `State` respectively.

The main motivation was that I wanted to separate UI code from logic, but am happy to pass down
the `ViewModel` via the constructor, i.e. I don't need the `Provider` or `ScopedModel` or
`InheritedWidget` magic which for my usecase add unnecessary complexity.

Basically all I need is to _bind_ the view to changes raised inside the `ViewModel`.

Both base classes are implemented inside [bound.dart](lib/ui/core/bound.dart) and look as
follows.

## BoundWidget

- used instead of `StatefulWidget`
- simply provides a `createViewModel` factory method which needs to be provided when calling it's
  `super` method
- the reason we need a factory method is that _ViewModels_ get disposed when the _View_ is
  detached and thus need to be created _fresh_ whenever `createState` is invoked on the widget,
  i.e. `_MyViewState createState() => _MyViewState(createViewModel());`

```dart
abstract class BoundWidget<TViewModel extends ChangeNotifier>
    extends StatefulWidget {
  final TViewModel Function() createViewModel;
  BoundWidget(this.createViewModel, {Key key}) : super(key: key);
}
```

### Example Use

```dart
class AddNumberView extends BoundWidget<AddNumberViewModel> {
  AddNumberView(createViewModel) : super(createViewModel);

  @override
  _AddNumberViewState createState() => _AddNumberViewState(createViewModel());
}
```

[add-number-view.dart](lib/ui/views/add_number_view.dart)

## BoundState

- used instead of `State<StatefulWidget>`
- takes a `viewModel` which needs to extend `ChangeNotifier` as input when constructed
  - [example ViewModel](lib/ui/viewmodels/add_number_view_model.dart)
- simply hooks changes raised by the `viewModel` into `setState` of the view

```dart
abstract class BoundState<TState extends StatefulWidget,
    TViewModel extends ChangeNotifier> extends State<TState> {
  final TViewModel viewModel;

  BoundState(this.viewModel) {
    viewModel.addListener(() {
      this.setState(noop);
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
```

### Example Use

```dart
class _AddNumberViewState
    extends BoundState<AddNumberView, AddNumberViewModel> {
  _AddNumberViewState(AddNumberViewModel viewModel) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    // [ .. ]
  }
}
```

[add-number-view.dart](lib/ui/views/add_number_view.dart)

## Sample App

The sample app just adds/removes and aggregates a list of numbers to demonstrate the
interactions of different views.

All state and stream sources are implemented inside
[NumberService](lib/services/number_service.dart).

All dependencies, including the service, views and viewmodels are registered/resolved via a
simple [locator](lib/locator.dart). The specific _Views_ are provided the _ViewModel_ factory
methods on navigation inside the [router](lib/ui/router.dart).

Only the top _ViewModels_ access that service directly. In one instance an _Observable_ is
passed down to a sub ViewModel. Sub ViewModels communicate actions via callbacks to keep things
simple. Only the top level _ViewModels_ then invoke a method on the service to incur a change.

All state and direct interaction with that state lives inside that service.

The _Views_ have no notion of the service or RX primitives. Instead they just interact with the
_ViewModel_ to which they are _bound_ either by pulling a property to display or invoking a
method when the user interacts with the UI.

## Summary

For now this approach works great for me in this example. I'll try it on a larger app and
possibly adjust the approach to further needs. Once I'm sure this covers most needs I'll
publish the _bound_ base classes as a package.

Feel free to file issues with questions, concerns and suggestions.
