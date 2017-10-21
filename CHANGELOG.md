## 10.0.0

### Enhancements
- **Gem Changes**
  - Updated to rails 5.1 defaults
  - Updated to ruby 2.4.2
  - Updated to bootstrap 4.0.0.beta2
  - Updated to carrierwave 1.2.1
  - Updated to haml 5.0.4

### Tests
- Added tests to assure user passwords can be reset

## 0.9.0 (October 21, 2017)

### Enhancements
- **General Changes**
  - Login cookies are now cross subdomain and work between www and non-www URLs
  - The DRTV page now redirects to the Work page
- **Member Changes**
  - Admins can now create and edit director and other team member pages
- **Video Changes**
  - Admins can now set Client Name and Agency Name for videos
  - Hovering over videos now displays Client Name and Agency Name
- **Gem Changes**
  - Updated to rails 5.1.4
  - Updated to pg 0.21.0
  - Updated to devise 4.3.0
  - Updated to carrierwave 1.1.0
  - Updated to haml 5.0.3
  - Updated to simplecov 0.15.1

## 0.8.2 (October 21, 2017)

### Enhancements
- **Gem Changes**
  - Updated to rails 5.0.6

## 0.8.1 (October 19, 2017)

### Bug Fix
- Fixed a bug that prevented passwords from being reset

## 0.8.0 (April 22, 2017)

### Enhancements
- **General Changes**
  - Pages redesigned by PixelCure
    - Home Page
    - Our Work
    - Directors
    - Clients
    - Contact
- **Video Changes**
  - System admins can now configure videos on the home page
- **Gem Changes**
  - Updated to Ruby 2.4.1
  - Updated to rails 5.0.2
  - Updated to jquery-rails 4.3.1
  - Updated to carrierwave 1.0.0
  - Updated to bootstrap-sass 3.3.7
  - Updated to jquery-ui-rails 6.0.1
  - Updated to kaminari 1.0.1
  - Updated to simplecov 0.14.1
  - Updated to pg 0.20.0
  - Added autoprefixer-rails

### Bug Fix
- Fixed a bug that prevented gallery photos from being rearranged after
  uploading a new photo

## 0.7.1 (February 6, 2017)

### Enhancements
- **General Changes**
  - Updated the link to the first video on the landing page

## 0.7.0 (December 20, 2016)

### Enhancements
- **General Changes**
  - Added a new Year in Review page

### Bug Fix
- Fixed a JavaScript that occurred when adding event listener to non-existent
  video

## 0.6.0 (October 16, 2016)

### Enhancements
- **General Changes**
  - Added new video to landing page
  - Added dropdown menu for logged in users
- **Email Changes**
  - Updated styling of emails
- **Client Changes**
  - Top level menu items are now hidden if they are empty
  - Subcategories no longer display in side menu if the containing gallery only
    has one subcategory
- **Document Changes**
  - Documents can now upload a PDF and Word version side-by-side
  - Categories with only one document no longer show latest and archived submenu
- **Gallery Changes**
  - Locations have been renamed to galleries
  - Gallery and photo positions can be reordered
- **Project Changes**
  - Top level REFERENCES has been added
  - Default categories for projects have been updated
  - Project usernames can no longer contain spaces
  - Admin and client logins have been combined
  - If a category has a single location, and no associated documents or embeds,
    then the client is redirected to the single location gallery view
  - Simplified links on project index to highlight preview link
  - URL slugs for projects, categories, and galleries now automatically fill in
    when entering a new name
  - Documents, embeds, and galleries can now be archived on from their index
    pages
  - Project main page layout has been updated while editing project
- **Gem Changes**
  - Updated to Ruby 2.3.1
  - Updated to rails 5.0.0.1
  - Updated to coffee-rails 4.2
  - Updated to jbuilder 2.5
  - Updated to jquery-rails 4.2.1
  - Updated to turbolinks 5
  - Updated to devise 4.2.0
  - Updated to simplecov 0.12.0
  - Updated to kaminari 0.17.0
  - Updated to haml 4.0.7
  - Updated to carrierwave 0.11.2
  - Updated to pg 0.19.0

### Refactoring
- Removed unused references to tumblr API
- Cleaned up routes file
- Cleaned up inviting and adding users to project
- Updated all views to use haml

### Bug Fixes
- Fixed a bug that prevented a project username from being reused if a deleted
  project had the same username
- Fixed a bug that prevented videos from hiding correctly on Work and DRTV pages
  when a video thumbnail was clicked

## 0.5.1 (April 23, 2016)

### Enhancements
- **Client Changes**
  - Internal client URLs are now friendly forwarded
  - Project submenus are now visible by default
- **Project Changes**
  - Project owners and editors can now archive projects
- **Email Changes**
  - Contacts through the website now go to a new email address
- **General Changes**
  - Added a JSON API for the site version
- **Gem Changes**
  - Updated to Ruby 2.3.0
  - Updated to rails 4.2.6
  - Updated to pg 0.18.4
  - Updated to devise 4.0.0
  - Updated to jquery-rails 4.1.1
  - Updated to carrierwave 0.11.0
  - Removed minitest-reporters
  - Added simplecov configuration file

### Bug Fix
- Deleted users are no longer able to log in
- Fixed an issue with duplicate scrollbars on some pages

## 0.5.0 (August 1, 2015)

### Enhancements
- **Client Changes**
  - Updated the internal client pages with cleaner layout
  - Client menu sidebar updated to match root menu design
  - Small footer graphic on client login page has been fixed
  - All latest and archived category documents and embeds are now listed in the
    archive menu in the sidebar
  - Fixed location of logos and spacing of header on client root menu
  - Clients can browse through locations and location photos
- **General Changes**
  - Product links no longer use `.html` extension
  - Primary link and accent color changed to lighter blue
  - Improved menu navigation when logged in
- **Document Changes**
  - Documents can be uploaded as PNGs as well
- **Location Changes**
  - Locations can be added that have a name, URL slug, and an address
  - Images can be uploaded to locations
    - Images are stored in three sizes
      - Full Images, Scaled to Fit 1024x1024
      - Previews, Scaled to Fit 360x360
      - Thumbnails, Centered to Fill 50x50
  - Locations are now listed as submenu items in the project menu
- **Administrative Changes**
  - Replaced `&middot;` with `|` for consistency in navigation
  - Administrators can edit and update user accounts
  - Administrators can add and remove videos from the WORK and DRTV pages
  - Administrators can reorder videos on the WORK and DRTV pages
- **Project Changes**
  - Project Owners can invite users to edit or view projects
  - Project Editors can edit the project, documents, embeds, categories
    - Only Project Owners can delete projects
  - Project Viewers can not make any changes, but can view project, documents,
    embeds, and categories
  - Project Owners, Editors, and Viewers can preview the client version of the
    site
- **Security Changes**
   - Made cookies secure in production environment

## 0.4.0 (July 9, 2015)

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
  - Updated to rails 4.2.3
  - Updated to pg 0.18.2

### Bug Fix
- Clicking the carousel indicators now correctly jumps to the selected video
- Documents and embeds now correctly set category while editing and updating
  them

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
  - Updated font family to `directors_cut_proregular` and
    `directors_cut_probold`
  - Updated social media links
  - The mobile view of the header logo now matches the full screen view
  - The logo lines to the left of the logo now extend past the edge of the
    screen on full screen view
  - The product links, "Commercials | Branded Content | Direct Response", now
    link to the appropriate pages
  - The product links no longer break across lines within the link itself on
    mobile views
  - The footer social links and copyright and name now match the size of the
    menu bar links

## 0.1.0 (May 12, 2014)

- **Splash Page Added**
  - The splash page contain contact information and a link to the original
    webpage
