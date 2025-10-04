# stepper_widget

A small Flutter demo app that demonstrates the Material `Stepper` widget in a clear, informative shipping-tracking UI.

Project context
- Purpose: Provide an example screen that shows how to use Flutter's `Stepper` (vertical) for multi-step workflows such as shipping/tracking or onboarding.
- Audience: Developers learning how Stepper works and product/UX reviewers who want a quick interactive prototype.

Key features
- A 5-step shipping timeline (Order placed → Processing → Packed → Shipped → Delivered).
- Interactive Stepper: tap a step to jump, Next/Back/Finish actions wired to explicit move logic.
- Custom-styled controls via `controlsBuilder` and a progress summary bar.

Files of interest
- `lib/stepper_demo.dart` — main demo screen implementing the Stepper example.

Run the demo
1. Make sure you have Flutter installed and a device or emulator available.
2. From the project root run:

```powershell
flutter pub get
flutter run
```

Placeholders for screenshots
Add screenshots to the repository (for example in `assets/screenshots/`) and update the paths below. Use PNG or JPG images sized for typical phone screenshots.

- Screenshot: Stepper home (desktop or phone)

	![Stepper home]![Starting Step](assets\screenshots\screenshot1.png)

- Screenshot: Stepper in-progress step

	![Stepper in progress](assets\screenshots\screenshot2.png)

Notes
- This demo intentionally keeps logic and UI in the same file for simplicity. If you want a production-ready structure I can extract widgets, add tests, and wire asset images into `pubspec.yaml`.

License
- This project is unlicensed; add a LICENSE file if you need one.
