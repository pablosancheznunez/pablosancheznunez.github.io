# pablosancheznunez.com

Personal academic website, built by GitHub Pages with Jekyll.

| File | What it holds |
| --- | --- |
| `index.html` | Home page: short bio, research interests and links (ORCID, email) |
| `_config.yml` | Name, affiliation, ORCID, email and site description |
| `cookies.html` | Cookie policy |
| `_layouts/default.html` | Shared head and footer |
| `assets/css/site.css`, `assets/js/site.js` | Styles and the small script for copying the email address |
| `consent.js` | Cookie consent; analytics load only after the visitor accepts |
| `reutilizacion-datos/` | Libro en Quarto *Reutilización de datos abiertos y documentos* (ya renderizado, con webR autoalojado). Se regenera desde el proyecto Quarto con `quarto render` y se copia aquí la carpeta `_book/` |
| `routes/` | Short addresses (pablosancheznunez.com/<package>/) that redirect to each package's own website |

The *Build* workflow builds the site on every push, so a mistake shows up as a failed check.
