<!-- PROJECT HEADER -->
<br />
<div align="center">
  <h3 align="center">Mall Navigator</h3>
</div>


<!-- ABOUT THE PROJECT -->
## About The Project

Visiting a mall is considered to be a time consuming process, if in a time constraint malls are always avoided. This application is designed for the mall visitors that want to make those speedy purchases. The application provide information about stores in the mall and deals or offer that are currently going on in their respective stores. The application consists of 3 targets, the Mall Owner, Store Owners and the Mall Visitors.

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- Admin Module -->
# Admin

The admin represents the mall owner, who is provided with the functionality to create or modify events, such as Black friday sale, car showcase, christmas choir; and also modify or assign new store informations.

## Login

<img src="/Screenshots/Admin/Login-1.png" width="207" height="448">		<img src="/Screenshots/Admin/Login-2.png" width="207" height="448">		<img src="/Screenshots/Admin/Login-3.png" width="207" height="448">

The Admin is allowed to use a personal email is used login. For the ease of use the "Sign up" and Google Sign-In are added for the time being and will be removed in the future for security reasons.

**Demo login credentials:**

> Email: test@admin.com <br/>
> Password: admin123

## Event

<img src="/Screenshots/Admin/Event-1.png" width="207" height="448">		<img src="/Screenshots/Admin/Event-2.png" width="207" height="448">		<img src="/Screenshots/Admin/Event-4.png" width="207" height="448">

These pages facilitates the admim to add special events or features that are held in the mall. <br/>
These might include events such as :
- Art Exibitions
- Car manufacturer showcase
- Fundraiser or charity event
- Christmas concerts or musicals

## Store

<img src="/Screenshots/Admin/Store-1.png" width="207" height="448">		<img src="/Screenshots/Admin/Store-2.png" width="207" height="448">		<img src="/Screenshots/Admin/Store-4.png" width="207" height="448">]

This page allows to add new or modify existing store.

## Search

<img src="/Screenshots/Admin/Event-Search-1.png" width="207" height="448">		<img src="/Screenshots/Admin/Store-Search-1.png" width="207" height="448">

The stores and events can be easily be searched using the search bar on their respective contollers

# Technologies Used

- The project is developed in Xcode using Swift and supports iPhone devices, as of now.
- Third party library integration were done using Cocapods.
- Version controllin is done using Git to maintain a local and remote repository.

#### UI Elements

- Used storyboards to design screens.
- Custom UI element classes.
- Extentions to native UI element class additional funtionality.
- List data was represented using UITableViews.
- Search controllers used along with lists.

#### Data storage

- Used Google's Firebase to store data on the cloud.
- Used Google libraries to communicate to the server.

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- Project Status -->

# Project Status

The project is under development with the below feature to be soon added in the future.

### UI Design

- [ ] Add Images to views.
- [ ] Redesign forms.
- [x] Make custom UI elements.
- [ ] Add Autolayout to all UI components.

### Admin 

- [ ] Create dashboard to display
	- [ ] Total sales charts and graph.
	- [ ] Total mall visitors.
	- [ ] Analytics to display busiest hours and most sales.
- [ ] Create a page to resolve Store Owner queries.
	
### Store Owner

- [ ] Create page to make a query to admin

### User 
- [ ] Add real-time navigation through the mall
- [ ] Create dashboard to display
	- [ ] Current mall events
	- [ ] New offers
