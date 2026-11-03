# pablosancheznunez.com

Personal academic website, built by GitHub Pages with Jekyll.

**To add or change a package or project, edit [`_data/work.yml`](_data/work.yml)** and push. The home page, the package filter, the install commands, the sitemap and the search-engine tags update themselves.

| File | What it holds |
| --- | --- |
| `_data/work.yml` | Every package, web tool, dataset and project shown on the home page |
| `_config.yml` | Name, affiliation, ORCID, email and site description |
| `index.html` | Home page template |
| `cookies.html` | Cookie policy |
| `_layouts/default.html` | Shared head and footer |
| `assets/css/site.css`, `assets/js/site.js` | Styles and the small script for filtering and copying |
| `consent.js` | Cookie consent; analytics load only after the visitor accepts |

The *Build* workflow builds the site on every push, so a mistake in the YAML shows up as a failed check.
