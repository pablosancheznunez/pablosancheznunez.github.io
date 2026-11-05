# pablosancheznunez.com

Personal academic website, built by GitHub Pages with Jekyll.

| File | What it holds |
| --- | --- |
| `index.html` | Home page: short bio, research interests and links (GitHub, ORCID, email) |
| `_config.yml` | Name, affiliation, ORCID, GitHub, email and site description |
| `cookies.html` | Cookie policy |
| `_layouts/default.html` | Shared head and footer |
| `assets/css/site.css`, `assets/js/site.js` | Styles and the small script for copying the email address |
| `consent.js` | Cookie consent; analytics load only after the visitor accepts |
| `routes/` | Short addresses (pablosancheznunez.com/<package>/) that redirect to each package's own website |

The *Build* workflow builds the site on every push, so a mistake shows up as a failed check.
