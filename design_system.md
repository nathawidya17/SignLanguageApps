# Tunarungu AR App - Design System
*Inspired by hearme.id design patterns*

## 🎨 Color Palette

### Primary Colors
- **Primary Teal**: `#4ECDC4` - Main brand color, used for primary actions and highlights
- **Secondary Teal**: `#45B7B8` - Supporting color for secondary elements
- **Light Teal**: `#96CEB4` - Background accents and subtle highlights
- **Soft Blue**: `#6C9BD1` - Secondary accent color for variety

### Neutral Colors
- **White**: `#FFFFFF` - Primary background and text on dark surfaces
- **Light Gray**: `#F8F9FA` - Secondary background
- **Medium Gray**: `#6C757D` - Secondary text and borders
- **Dark Gray**: `#343A40` - Primary text color
- **Black**: `#000000` - High contrast text when needed

### Semantic Colors
- **Success**: `#28A745` - Success states and positive feedback
- **Warning**: `#FFC107` - Warning states and attention
- **Error**: `#DC3545` - Error states and critical actions
- **Info**: `#17A2B8` - Informational content

## 📝 Typography

### Font Family
- **Primary**: `'Poppins', 'SF Pro Display', 'Roboto', sans-serif`
- **Secondary**: `'Inter', 'Helvetica Neue', sans-serif`

### Font Sizes & Weights
```
Heading 1: 32px, Bold (700)
Heading 2: 28px, SemiBold (600)
Heading 3: 24px, SemiBold (600)
Heading 4: 20px, Medium (500)
Body Large: 18px, Regular (400)
Body: 16px, Regular (400)
Body Small: 14px, Regular (400)
Caption: 12px, Regular (400)
Button: 16px, Medium (500)
```

## 🧩 Component Design Patterns

### Cards
- **Elevation**: 2-4dp shadow
- **Border Radius**: 16px
- **Padding**: 20px
- **Background**: White with subtle teal accent borders
- **Hover State**: Slight elevation increase and teal glow

### Buttons
- **Primary Button**: Teal background, white text, 12px border radius
- **Secondary Button**: White background, teal border and text
- **Icon Buttons**: Circular, 48px diameter, teal background
- **Floating Action Button**: 56px diameter, primary teal, white icon

### Navigation
- **Bottom Navigation**: 4 tabs with icons and labels
- **Tab Height**: 64px
- **Active State**: Primary teal color with icon fill
- **Inactive State**: Medium gray with outline icons

### Input Fields
- **Border**: 1px solid light gray, focus state with teal border
- **Border Radius**: 8px
- **Padding**: 16px horizontal, 12px vertical
- **Background**: White with subtle shadow

## 🎭 Visual Elements

### Illustrations
- **Style**: 3D rendered characters similar to hearme.id
- **Color Scheme**: Consistent with brand colors
- **Character Design**: Friendly, approachable, diverse representation

### Icons
- **Style**: Rounded, filled for active states, outlined for inactive
- **Size**: 24px standard, 32px for prominent actions
- **Color**: Follows semantic color system

### Gradients
- **Primary Gradient**: `linear-gradient(135deg, #4ECDC4 0%, #45B7B8 100%)`
- **Background Gradient**: `linear-gradient(180deg, #F8F9FA 0%, #FFFFFF 100%)`
- **Accent Gradient**: `linear-gradient(45deg, #96CEB4 0%, #6C9BD1 100%)`

## 📱 Layout Principles

### Spacing System (8px grid)
- **XS**: 4px
- **SM**: 8px
- **MD**: 16px
- **LG**: 24px
- **XL**: 32px
- **XXL**: 48px

### Screen Layouts
- **Safe Area**: Respect device safe areas
- **Content Padding**: 16px horizontal margin
- **Section Spacing**: 24px between major sections
- **Card Spacing**: 16px between cards

## ♿ Accessibility Guidelines

### Color Contrast
- **Text on Background**: Minimum 4.5:1 ratio
- **Large Text**: Minimum 3:1 ratio
- **Interactive Elements**: Clear focus indicators

### Touch Targets
- **Minimum Size**: 44px x 44px
- **Spacing**: 8px minimum between targets
- **Visual Feedback**: Clear pressed/focused states

### Sign Language Considerations
- **High Contrast**: Ensure sign language GIFs are clearly visible
- **Large Touch Areas**: Easy navigation for users with motor difficulties
- **Clear Visual Hierarchy**: Important information stands out

## 🎬 Animation Guidelines

### Transitions
- **Duration**: 200-300ms for micro-interactions
- **Easing**: `cubic-bezier(0.4, 0.0, 0.2, 1)` - Material Design standard
- **Page Transitions**: 400ms slide animations

### Loading States
- **Skeleton Screens**: For content loading
- **Progress Indicators**: Teal colored, smooth animations
- **Micro-interactions**: Button press feedback, card hover effects

## 📐 Component Specifications

### Home Screen Hero Section
- **Height**: 40% of screen height
- **Background**: Primary gradient
- **Content**: Centered illustration + welcome text
- **CTA Button**: Primary button style, prominent placement

### Vocabulary Cards
- **Aspect Ratio**: 3:4 (width:height)
- **Image Area**: 60% of card height
- **Text Area**: 40% of card height
- **Border**: 2px teal accent on hover/focus

### AR View Interface
- **Overlay Elements**: Semi-transparent backgrounds
- **Control Buttons**: Floating, circular, with drop shadows
- **Information Cards**: Slide up from bottom, rounded top corners

### Bottom Navigation
- **Icons**: Home, AR Camera, Book (Vocabulary), User (Profile)
- **Labels**: Always visible, 12px font size
- **Indicator**: Teal background pill for active tab

## 🔧 Implementation Notes

### Flutter Specific
- Use `Material 3` design system as base
- Implement custom `ColorScheme` with teal primary colors
- Create reusable `ThemeData` with consistent styling
- Use `Hero` widgets for smooth page transitions
- Implement `AnimatedContainer` for micro-interactions

### Asset Requirements
- High-quality sign language GIFs (optimized for mobile)
- 3D character illustrations (PNG with transparency)
- Icon set (SVG format for scalability)
- Logo variations (light/dark backgrounds)

This design system ensures consistency with hearme.id's approachable, accessible design while creating a unique identity for your AR learning app.