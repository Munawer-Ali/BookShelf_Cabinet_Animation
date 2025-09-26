# Bookshelf Cabinet Animation

A Flutter app that demonstrates animated bookshelf customization with interactive wood shelves and lighting effects.

## Features

- **Interactive Bookshelf**: Animated wood shelves that slide in and out
- **Lighting Effects**: Customizable lighting with glow effects
- **Expandable UI Sections**: Collapsible furniture and lighting configuration panels
- **Smooth Animations**: Custom elastic curves for natural motion
- **Responsive Design**: Adapts to different screen sizes

## Project Structure

```
lib/
├── main.dart                    # Main app entry point
├── widgets/
│   ├── book_shelf_widget.dart   # Main bookshelf display widget
│   ├── bulb_light.dart          # Lighting effect widget
│   └── animated_tab_selector.dart # Reusable tab selector component
└── utils/
    └── elastic_curve.dart       # Custom animation curve
```

## Widgets

### BookShelfWidget
- Displays the main bookshelf with animated wood shelves
- Controls shelf visibility and positioning
- Integrates lighting effects

### BulbLight
- Creates glowing light effects
- Customizable size, color, and glow radius
- Used for shelf lighting

### AnimatedTabSelector
- Reusable tab selector with animated indicator
- Smooth transitions between options
- Customizable appearance and behavior

### CustomElasticOutCurve
- Custom animation curve with reduced bounce
- Provides natural, elastic motion
- Used throughout the app for smooth animations

## Testing

The project includes comprehensive Flutter tests covering:

- Widget rendering and properties
- User interactions and state changes
- Animation behavior
- Integration testing
- Performance testing

Run tests with:
```bash
flutter test
```

## Usage

1. **Furniture Configuration**: Tap "Make your furniture" to expand options
   - Select number of shelves (One, Two, Three)
   - Choose size (Square, Wide, Tall)

2. **Lighting Configuration**: Tap "Choose Lightening" to expand options
   - Select lighting type (None, Bulb, Strip)

3. **Interactive Elements**: 
   - Wood shelves animate in/out based on selection
   - Lighting effects appear/disappear with smooth transitions
   - All animations use custom elastic curves

## Dependencies

- Flutter SDK
- No external dependencies required

## Assets

- `assets/bookshelf.png` - Main bookshelf background
- `assets/wood.png` - Wood shelf texture
- `assets/light.png` - Light fixture image
- `assets/foot.png` - Furniture base image

## Development

The code is organized into separate, reusable widgets for maintainability:

- Each widget has a single responsibility
- Custom animation curves are centralized
- Tests ensure reliability and prevent regressions
- Clean separation between UI and logic

## Future Enhancements

- Additional furniture types
- More lighting options
- Color customization
- Save/load configurations
- 3D effects