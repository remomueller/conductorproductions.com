## 0.4.0

### Enhancements
- **Administrative Changes**
  - Users can now register and sign in to the website
  - System admin role has been added
- **Project Changes**
  - System admins can create and edit projects
  - Projects can have:
    - Project Name
    - Project Number
    - Project Agency Logo
    - Project Client Logo
    - URL Slug
    - Client Name
    - Client Username
    - Client Password
  - System admins can now create and edit project categories
    - Categories are created under a top level menu item
  - System admins can now upload documents to categories
    - Documents can be archived
  - System admins can now embed iframes in categories
    - Embeds can be archived
- **General Changes**
  - Added a version page
  - Updated font location for better asset management using Rails
  - Enable Google Analytics in production only
  - Updated contact page form to use new Rails mailer
- **Client Changes**
  - Clients can now login to a project
  - Clients can view the following pages:
    - Project Main Menu
    - Creative / Script
    - Timeline
    - Production / Casting
  - Added Conductor WeTransfer link to footer
- **Email Changes**
  - Updated password reset and unlock emails to use the correct website URL
- **Gem Changes**
  - Added figaro centralized configuration
  - Updated to rails 4.2.2
  - Updated to pg 0.18.2

## 0.3.1 (May 3, 2015)

### Enhancements
- **Home Page**
  - Added fifth video to home page

## 0.3.0 (May 3, 2015)

### Enhancements
- **Home Page**
  - Added carousel of four videos to home page
  - Improved text width on smaller devices for text below video carousel
  - Shortened the copy on the home page
- **Work Page**
  - Updated copy text and increased font size
  - Added 12 new videos to work page
- **DRTV Page**
  - Updated copy text and increased font size
  - Added 7 new videos to DRTV page
- **News Page**
  - Removed from the website for the time being
- **General Changes**
  - Updated year in footer to automatically get current year
  - Added Google Analytics
- **Gem Changes**
  - Updated to rails 4.2.1
  - Updated to pg 0.18.1
  - Using haml now for views
  - Use of Ruby 2.2.2 is now recommended
  - Updated to simplecov 0.10.0

## 0.2.1

- **Home Page**
  - Updated video link
  - Updated main text on home page

- **DRTV Page**
  - Added six additional videos and reshuffled order

- **Work Page**
  - Added three additional videos and reshuffled order

## 0.2.0

### Enhancements
- **Work and DRTV Page Added**
  - Contains 9 video thumbnails with vimeo links
  - Added diagonal line to separate headers and text on full screen view
  - Added white triangle cutouts on full screen view for videos container
  - Darkened background opacity when playing videos
  - Added link to contact form from DRTV page
  - Videos automatically close when they finish

- **News Page Added**
  - Contains graphics and "No News Is Good News"

- **Contact Page Added**
  - Contains an embedded email form
  - Contains address and an embedded google maps frame

- **General Changes**
  - Updated favicon to .ico based on `CON_FB_160x160_R1_2.png`
  - Updated font family to `directors_cut_proregular` and `directors_cut_probold`
  - Updated social media links
  - The mobile view of the header logo now matches the full screen view
  - The logo lines to the left of the logo now extend past the edge of the screen on full screen view
  - The product links, "Commercials | Branded Content | Direct Response", now link to the appropriate pages
  - The product links no longer break across lines within the link itself on mobile views
  - The footer social links and copyright and name now match the size of the menu bar links

## 0.1.0 (May 12, 2014)

- **Splash Page Added**
  - The splash page contain contact information and a link to the original webpage
