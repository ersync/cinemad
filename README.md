

# CinEmad 🎬

<div align="center">
	<a href="https://github.com/user-attachments/assets/f3d2f6ba-ec4a-4075-8e5f-0ed6231e6445" target="_blank">
		<img src="https://github.com/user-attachments/assets/f3d2f6ba-ec4a-4075-8e5f-0ed6231e6445" width="350" alt="Inception Full Page"/>
	</a>
	<a href="https://github.com/user-attachments/assets/95a89499-b26e-46ff-bafd-82f6db16859f" target="_blank">
	<img src="https://github.com/user-attachments/assets/95a89499-b26e-46ff-bafd-82f6db16859f" width="350" alt="The Dark Knight Full Page"/>
	</a>
</div>

<div align="center">

### A feature-rich film discovery application built with Ruby on Rails and Vue.js

<p>
  <a href="https://cinemad.emadrahimi.dev" target="_blank"><img src="https://img.shields.io/badge/✨_Live_Demo-1a365d?style=for-the-badge" alt="Live Demo"></a>   
  <a href="https://emadrahimi.dev" target="_blank"><img src="https://img.shields.io/badge/Portfolio-008080?style=for-the-badge" alt="Portfolio"></a>
</p>

</div>


## Table of Contents
- [Overview](#overview)
- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
- [Architecture](#architecture)
- [Deployment](#deployment)
- [Lessons Learned](#lessons-learned)
- [License](#license)

## Overview

**CinEmad** started as my final learning project but soon evolved into a comprehensive endeavor with a focus on user experience and technical implementation. The project demonstrates full-stack development techniques across a modern tech stack, implementing practical features while maintaining clean architecture and responsive design.

## Key Features

- **Comprehensive movie database** with detailed film information
- **Clean RESTful API** with secure authentication using Devise
- **Advanced search and filtering** across multiple criteria
- **Reactive frontend** using Vue's state management and real-time updates
- **Responsive design** optimized for mobile and desktop experiences
- **User profiles** with watchlists, favorites, ratings, and reviews
- **Dark Theme support** with seamless light/dark mode transitions

The codebase includes +100 Vue components and +20 ActiveRecord models.

## Tech Stack

**Frontend:**
- Vue.js 3 (Composition API)
- Vue Router for navigation
- Pinia for state management
- Tailwind CSS for styling
- Vite for build tooling

**Backend:**
- Ruby on Rails 7
- PostgreSQL database

**Authentication:**
- Devise

**Testing:**
- RSpec

## Screenshots

<div align="center">
  <table>
	<tr>
	  <td><img src="https://github.com/user-attachments/assets/2a082c57-c032-4799-88bf-3f6f0c6c08d1" width="300" alt="Mobile Login Page"></td>
	  <td><img src="https://github.com/user-attachments/assets/ca26d259-f037-4610-b994-a89aab77e7ac" width="300" alt="Mobile Menu"></td>
	  <td><img src="https://github.com/user-attachments/assets/cf4b28e7-1120-4070-85f2-0370384a7c70" width="300" alt="Mobile Reviews Page"></td>
	  <td><img src="https://github.com/user-attachments/assets/7e642c0f-a6e7-44c4-8a9e-82cc61a6e544" width="300" alt="Mobile Show Page"></td>
	</tr>
	<tr>
	  <td><img src="https://github.com/user-attachments/assets/d68abafd-b947-4622-a941-1822dbe2e903" width="300" alt="Desktop Profile Page"></td>
	  <td><img src="https://github.com/user-attachments/assets/b8ab4d59-5d73-401b-b69a-a2862657cf9e" width="300" alt="Desktop Discovery Page"></td>
	  <td><img src="https://github.com/user-attachments/assets/fd635f2a-7830-4f1e-a03c-fab5d0e470fe" width="300" alt="Desktop Light Theme Login Page"></td>
	  <td><img src="https://github.com/user-attachments/assets/63fe0efe-3f76-4ac3-8ff0-9a55e6ca842b" width="300" alt="Desktop Dark Theme Login Page"></td>
	</tr>
  </table>
</div>

## Getting Started

### Prerequisites

- Ruby 3.0+
- Node.js 18+
- PostgreSQL 12+
- Yarn

### Installation

```bash
# Clone the repository
git clone https://github.com/ersync/cinemad.git
cd cinemad

# Install dependencies
bundle install
yarn install

# Setup database and attach media assets
bin/rails db:create db:migrate db:seed
bin/rails movies:attach_all_media  # Attaches images and media files to movie and people records
```


### Running Locally

Start the development servers (in separate terminals):

```bash
# Terminal 1: Rails API server
bin/rails server

# Terminal 2: Vite development server for Vue frontend
bin/vite dev
```


Then visit `http://localhost:3000` in your browser.

## Architecture

### Backend

The Rails API implements a clean architecture with:

- **20+ ActiveRecord models** with complex relationships
- **PORO Pattern**: Extensive use of Plain Old Ruby Objects for business logic
- **Service Objects**: Dedicated classes for complex operations and external integrations
- **Serializers**: Custom JSON serialization for optimized API responses
- **Skinny Controllers**: Controllers delegating to service objects for maintainable code
- **Advanced filtering system** combining multiple criteria (genres, release dates, languages)
- **Rake Tasks**: Composable tasks with an all-in-one setup command

The application features a fairly complex relational database structure:

<img src="https://github.com/user-attachments/assets/878f2ac5-81e6-4b5e-b7b2-897839d5b1c6" alt="Database Schema Diagram" style="height: 500px; width: auto;">

### Frontend

The Vue.js frontend features a sophisticated component architecture:

- **100+ Vue Components**: Organized in a maintainable hierarchy for reusability
- **State Management**: Uses Pinia with four specialized stores:
  - `auth`: Handles user authentication state
  - `movies`: Manages movie data and filtering
  - `userInteraction`: Tracks ratings, reviews, and watchlist actions
  - `loading`: Controls loading states and UI feedback
- **Theme Support**: Built-in dark mode with a simple toggle between light and dark interfaces
- **Reactivity**: Instant visual feedback for ratings, watchlists, favorites and other user interactions
  
<div align="center">
  <img src="https://github.com/user-attachments/assets/bc4694c4-768c-4bd6-ae4b-fa1f3a86cd7d" width="320" alt="Mobile Action Panel" style="margin-right: 5px; margin-bottom: 5px;">
  <img src="https://github.com/user-attachments/assets/7eb2454b-379f-404c-9f22-9dc6df72f78c" width="450" alt="Desktop Action Panel" style="margin-bottom: 5px;">
</div>

### Mobile-First Design

The application was designed with mobile users in mind first:

- Device-specific components where appropriate
- Touch-friendly interfaces with appropriate tap targets
- Optimized media loading for various connection speeds
- Automatic switching between light and dark modes based on device settings
- Manual theme toggle for user preference override

## Deployment

Deploying a Rails application for free turned out to be surprisingly elusive. What many developers consider the "free Rails hosting landscape" has largely become a mirage. Despite advertising free tiers, platforms like Render and Fly.io still required credit card information upfront, Railway's complimentary credits vanished quickly, and alternative PaaS solutions came with similarly restrictive conditions.


Ultimately, I deployed CinEmad on a budget-friendly VPS with the following setup:
- Ubuntu 20.04 LTS
- Nginx as reverse proxy with SSL via **Let's Encrypt**
- Puma application server
- PostgreSQL database

Rather than using **Capistrano**, I opted for a manual deployment approach to gain deeper insights into the Linux server environment and deployment process. This hands-on experience provided valuable learning opportunities about server configuration, environment setup, and application monitoring. The current server isn't particularly powerful, but it's sufficient to showcase this demo project's capabilities while keeping costs manageable.

## Lessons Learned

This project taught me more than just Rails and Vue fundamentals:

- **Managing complexity** in large codebases
- **Planning component architecture** for maintainability
- **Performance optimization** for media-heavy applications
- **Progressive enhancement** for diverse user devices

CinEmad represents my growth as a developer and has strengthened my ability to build full-stack applications that balance technical functionality with user experience.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
