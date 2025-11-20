# Figma SUS Template Implementation Guide
## AR Aplikasi Pembelajaran untuk Tunarungu

### 🎨 Design System untuk SUS Template

#### Color Palette:
```
Primary Blue: #2196F3
Success Green: #4CAF50
Warning Orange: #FF9800
Error Red: #F44336
Neutral Gray: #9E9E9E
Background: #FFFFFF
Text Primary: #212121
Text Secondary: #757575
```

#### Typography:
```
Heading: Inter Bold, 24px
Subheading: Inter SemiBold, 18px
Body: Inter Regular, 16px
Caption: Inter Regular, 14px
```

#### Spacing:
```
8px, 16px, 24px, 32px, 48px
```

---

## 📱 Mobile-First Design Components

### 1. Header Section
```
┌─────────────────────────┐
│    SUS Evaluation       │
│  AR Learning App        │
│  [Logo/Icon]            │
└─────────────────────────┘
```

### 2. Instructions Card
```
┌─────────────────────────┐
│ 📋 Instructions         │
│                         │
│ Berikan penilaian dari │
│ 1-5 untuk setiap       │
│ pernyataan berikut:     │
│                         │
│ 1 = Sangat Tidak Setuju│
│ 5 = Sangat Setuju      │
└─────────────────────────┘
```

### 3. Question Card Template
```
┌─────────────────────────┐
│ Q1. Question Text       │
│                         │
│ ○ 1 - Sangat Tidak     │
│    Setuju               │
│ ○ 2 - Tidak Setuju     │
│ ○ 3 - Netral           │
│ ○ 4 - Setuju           │
│ ○ 5 - Sangat Setuju    │
│                         │
│ [Previous] [Next]      │
└─────────────────────────┘
```

### 4. Progress Indicator
```
┌─────────────────────────┐
│ Progress: 3/15          │
│ ████████░░░░░░░░ 53%   │
└─────────────────────────┘
```

---

## 🎯 Component Specifications

### Question Card:
- **Width**: 100% of container
- **Height**: Auto (min 200px)
- **Padding**: 24px
- **Border Radius**: 12px
- **Shadow**: 0 2px 8px rgba(0,0,0,0.1)
- **Background**: White

### Radio Button:
- **Size**: 20px diameter
- **Color**: Primary Blue when selected
- **Border**: 2px solid #E0E0E0
- **Spacing**: 16px between options

### Navigation Buttons:
- **Height**: 48px
- **Border Radius**: 8px
- **Primary Button**: Blue background
- **Secondary Button**: Gray border

---

## 📊 Data Visualization Components

### 1. Score Summary Card
```
┌─────────────────────────┐
│ 📊 Your SUS Score       │
│                         │
│ Overall Score: 87.5     │
│ Grade: A (Excellent)    │
│                         │
│ [View Details]          │
└─────────────────────────┘
```

### 2. Score Breakdown
```
┌─────────────────────────┐
│ 📈 Score Breakdown      │
│                         │
│ Usability: 85/100       │
│ ██████████░░ 85%       │
│                         │
│ Accessibility: 90/100   │
│ ████████████ 90%       │
│                         │
│ Learning: 88/100        │
│ ███████████░ 88%       │
└─────────────────────────┘
```

### 3. Comparison Chart
```
┌─────────────────────────┐
│ 📊 Benchmark Comparison │
│                         │
│ Your App: ████████ 80% │
│ Industry Avg: █████ 60%│
│ Target: ████████ 80%   │
└─────────────────────────┘
```

---

## 🔄 Interactive States

### Default State:
- Question text in primary color
- Radio buttons in neutral gray
- Navigation buttons enabled

### Selected State:
- Selected radio button in primary blue
- Question number highlighted
- Progress bar updated

### Completed State:
- All questions answered
- Submit button highlighted
- Success message displayed

### Error State:
- Missing answers highlighted in red
- Error message displayed
- Navigation blocked until resolved

---

## 📱 Responsive Design

### Mobile (320px - 480px):
- Single column layout
- Full-width cards
- Large touch targets (44px minimum)
- Simplified navigation

### Tablet (481px - 768px):
- Two-column layout for questions
- Side-by-side navigation
- Larger text and spacing

### Desktop (769px+):
- Multi-column layout
- Hover states for buttons
- Detailed progress indicators
- Advanced analytics display

---

## 🎨 Accessibility Features

### Visual Design:
- **High Contrast**: 4.5:1 minimum ratio
- **Large Text**: 16px minimum
- **Clear Icons**: 24px minimum
- **Consistent Spacing**: 8px grid system

### Interactive Elements:
- **Focus Indicators**: Clear blue outline
- **Touch Targets**: 44px minimum
- **Color Independence**: Not relying solely on color
- **Keyboard Navigation**: Full keyboard support

### Screen Reader Support:
- **Semantic HTML**: Proper heading structure
- **Alt Text**: Descriptive labels for images
- **ARIA Labels**: Clear descriptions for interactive elements
- **Skip Links**: Quick navigation options

---

## 📊 Data Collection Flow

### Step 1: Welcome Screen
```
┌─────────────────────────┐
│ 👋 Welcome!             │
│                         │
│ Thank you for           │
│ participating in our    │
│ usability study.        │
│                         │
│ This will take about    │
│ 10-15 minutes.          │
│                         │
│ [Start Evaluation]      │
└─────────────────────────┘
```

### Step 2: Participant Info
```
┌─────────────────────────┐
│ 👤 Participant Info     │
│                         │
│ Name: [Input]           │
│ Age: [Input]            │
│ Experience with AR:     │
│ [Beginner/Intermediate/ │
│  Advanced]              │
│                         │
│ [Continue]              │
└─────────────────────────┘
```

### Step 3: Question Flow
```
┌─────────────────────────┐
│ Q1/15                  │
│                         │
│ I think I would like to│
│ use this app regularly. │
│                         │
│ ○ 1 - Strongly Disagree│
│ ○ 2 - Disagree         │
│ ○ 3 - Neutral          │
│ ○ 4 - Agree            │
│ ○ 5 - Strongly Agree   │
│                         │
│ [Previous] [Next]      │
└─────────────────────────┘
```

### Step 4: Results Summary
```
┌─────────────────────────┐
│ 🎉 Evaluation Complete! │
│                         │
│ Your SUS Score: 87.5    │
│ Grade: A (Excellent)    │
│                         │
│ Thank you for your      │
│ valuable feedback!       │
│                         │
│ [Download Report]       │
└─────────────────────────┘
```

---

## 🔧 Implementation Checklist

### Design Setup:
- [ ] Create Figma project
- [ ] Set up design system
- [ ] Create component library
- [ ] Build responsive layouts
- [ ] Test accessibility features

### Content Creation:
- [ ] Write all 15 questions
- [ ] Create instructions
- [ ] Design participant info form
- [ ] Build results summary
- [ ] Add qualitative feedback section

### Technical Implementation:
- [ ] Set up form validation
- [ ] Implement scoring algorithm
- [ ] Create data export
- [ ] Add progress tracking
- [ ] Test all interactions

### Testing:
- [ ] Test on multiple devices
- [ ] Verify accessibility compliance
- [ ] Validate scoring accuracy
- [ ] Test data collection
- [ ] User acceptance testing

---

## 📈 Analytics Integration

### Data Points to Track:
- **Completion Rate**: % of users who finish
- **Time per Question**: Average response time
- **Drop-off Points**: Where users abandon
- **Score Distribution**: Range and frequency
- **Device Usage**: Mobile vs desktop

### Export Options:
- **CSV Format**: For statistical analysis
- **PDF Report**: For stakeholders
- **JSON API**: For integration
- **Real-time Dashboard**: For monitoring

---

*Template ini dapat diimplementasikan di Figma dengan mengikuti spesifikasi design system dan accessibility guidelines yang telah ditentukan.* 