# 🐱 Kitten Lovers - E-commerce Platform

## 📋 Project Overview

**Kitten Lovers** is an e-commerce platform dedicated to selling high-quality kitten photographs. Built with Ruby on Rails 8.0.2, this project aims to create a modern, user-friendly online marketplace for feline photography enthusiasts.

**Live Site**: https://kitten-lovers-d41eb669d13c.herokuapp.com/

---

## 🎯 Business Objectives

### Mission

Create a specialized platform for selling professional kitten photographs, targeting the animal photography market with a focus on quality and user experience.

### Target Market

- **Primary**: Individuals aged 16-40 seeking gifts for grandparents
- **Secondary**: Cat lovers and photography enthusiasts
- **Tertiary**: Pet owners looking for artistic representations

### Revenue Goals

- **Year 1**: €20,000 in photo sales
- **Year 3**: €250,000 with product diversification (mugs, magnets, stickers)

---

##

### Development Team

- **Théo BANNERY** - Full Stack Developer
- **Florian BENOIT** - Full Stack Developer
- **Matthieu MARILLER** - Full Stack Developer

---

## 🛠️ Technical Stack

### Backend

- **Framework**: Ruby on Rails 8.0.2
- **Database**: PostgreSQL
- **Authentication**: Devise (planned)
- **Payment**: Stripe integration (planned)

### Frontend

- **JavaScript**: Stimulus framework
- **Styling**: CSS modules (no inline styles)
- **Responsive**: Mobile-first approach

### Deployment

- **Platform**: Heroku
- **Pipeline**: Automated deployment from main branch

---

## 🏗️ Architecture

### MVC Pattern

- **Models**: Product, User, Order, OrderItem
- **Controllers**: Generated with Rails scaffolding
- **Views**: Partials-based with Stimulus controllers

### Database Design

```sql
-- Core entities
Products (kitten photos)
Users (customers)
Orders (purchase transactions)
OrderItems (individual items in orders)
Categories (photo categories)
```

### Key Features

- **Product Catalog**: Browse and filter kitten photos
- **Shopping Cart**: Add/remove items with live updates
- **User Authentication**: Registration and login system
- **Order Management**: Complete purchase workflow
- **Admin Panel**: Product and order management
- **Responsive Design**: Mobile and desktop optimization

---

## 🚀 Getting Started

### Prerequisites

- Ruby 3.2+
- Rails 8.0.2
- PostgreSQL
- Node.js (for Stimulus)

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/kitten_lovers.git
cd kitten_lovers

# Install dependencies
bundle install
npm install

# Database setup
rails db:create
rails db:migrate
rails db:seed

# Start the server
rails server
```

### Environment Variables

```env
DATABASE_URL=postgresql://username:password@localhost/kitten_lovers
STRIPE_PUBLIC_KEY=your_stripe_public_key
STRIPE_SECRET_KEY=your_stripe_secret_key
```

---

## 📱 Features

### Customer Features

- **Photo Gallery**: High-resolution kitten photo browsing
- **Advanced Search**: Filter by breed, color, pose, mood
- **Shopping Cart**: Real-time cart management with Stimulus
- **Secure Checkout**: Stripe payment integration
- **User Profiles**: Order history and favorites
- **Mobile Responsive**: Optimized for all devices

### Admin Features

- **Product Management**: Add, edit, delete photos
- **Order Processing**: View and manage customer orders
- **Analytics Dashboard**: Sales metrics and insights
- **User Management**: Customer account oversight

### Technical Features

- **Stimulus Controllers**: Interactive UI components
- **Partial Templates**: Reusable view components
- **AJAX Updates**: Seamless user interactions
- **Image Optimization**: Fast loading, multiple formats
- **SEO Friendly**: Optimized meta tags and URLs

---

## 🎨 Design Principles

### Code Standards

- **Separation of Concerns**: No mixing HTML and CSS
- **English Comments**: All code comments in English
- **Minimal Comments**: Only for major code blocks
- **Scaffold Usage**: Maximize Rails scaffolding
- **Stimulus First**: JavaScript handled by Stimulus controllers

### UI/UX Guidelines

- **Mobile First**: Responsive design approach
- **Clean Interface**: Minimalist, cat-focused design
- **Fast Loading**: Optimized images and assets
- **Accessibility**: WCAG 2.1 compliant

---

## 🔄 Development Workflow

### Branch Strategy

- **main**: Production-ready code
- **develop**: Integration branch
- **feature/**: Individual feature branches

### Code Review Process

1. Create feature branch
2. Implement changes with tests
3. Submit pull request
4. Code review and approval
5. Merge to develop
6. Deploy to staging
7. Production deployment

---

## 📊 Competitive Analysis

### Direct Competitors

- **Etsy**: Handmade and vintage marketplace
- **Redbubble**: Print-on-demand platform
- **Shutterstock**: Stock photography platform

### Competitive Advantages

- **Specialized Niche**: Focus on kitten photography
- **Quality Curation**: Professional photographer selection
- **Personal Touch**: Direct artist-customer relationship
- **Future Products**: Expansion to physical merchandise

---

## 🤝 Contributing

### Development Guidelines

1. Follow Rails conventions
2. Use Stimulus for JavaScript interactions
3. Maintain partial-based view structure
4. Write descriptive commit messages
5. Include tests for new features

### Getting Help

- Create issues for bugs or feature requests
- Use descriptive titles and detailed descriptions
- Include screenshots for UI-related issues

---

## 📄 License

This project is proprietary software owned by Kitten Lovers team.

---

## 🐾 Acknowledgments

Created with 😻 and lots of 🐾 by the passionate team at Kitten Lovers.

Special thanks to our photographers and the feline models who make this project possible!
