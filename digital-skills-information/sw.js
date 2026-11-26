/* Service worker del libro (generado por herramientas/preparar.py).
   Guarda el libro y el motor de R (webR) para que funcionen sin conexión
   después de la primera visita.
   - Páginas (HTML) y buscador: primero la red; si no hay conexión, la copia.
   - webR, paquetes, estilos, figuras y datos: primero la copia; si no está,
     la red, y se guarda.
   Cambia VERSION en cada versión publicada para renovar la caché. */
const VERSION = "1.1.0";
const CACHE = "digital-skills-information-" + VERSION;
const BASE = new URL("./", self.location).pathname;

const PAGINAS = ["", "index.html", "00-r-in-this-book.html", "01-sources.html", "02-retrieval.html", "03-ethics-plagiarism.html", "04-references.html", "05-ai-foundations.html", "06-ai-ethics.html", "90-citations.html", "93-checklists.html", "94-verification.html", "91-teaching-guide.html", "92-glossary.html", "search.json"];

self.addEventListener("install", (evento) => {
  evento.waitUntil(
    caches.open(CACHE)
      .then((c) => Promise.allSettled(PAGINAS.map((p) => c.add(BASE + p))))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (evento) => {
  evento.waitUntil(
    caches.keys()
      .then((claves) => Promise.all(claves
        .filter((k) => k.startsWith("digital-skills-information-") && k !== CACHE)
        .map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

function esPagina(peticion, url) {
  return peticion.mode === "navigate" || url.pathname.endsWith(".html") ||
    url.pathname.endsWith("/") || url.pathname.endsWith("search.json");
}

async function primeroRed(peticion) {
  const cache = await caches.open(CACHE);
  try {
    const respuesta = await fetch(peticion);
    if (respuesta.ok) cache.put(peticion, respuesta.clone());
    return respuesta;
  } catch (e) {
    const guardada = await cache.match(peticion, { ignoreSearch: true });
    if (guardada) return guardada;
    throw e;
  }
}

async function primeroCopia(peticion) {
  const cache = await caches.open(CACHE);
  const guardada = await cache.match(peticion, { ignoreSearch: true });
  if (guardada) return guardada;
  try {
    const respuesta = await fetch(peticion);
    if (respuesta.ok && respuesta.status === 200) cache.put(peticion, respuesta.clone());
    return respuesta;
  } catch (e) {
    // Sin conexión: webR comprueba si existen algunos ficheros opcionales.
    // Un «no encontrado» le permite seguir; un error de red lo detendría.
    return new Response("", { status: 404, statusText: "Sin conexión" });
  }
}

// webR comprueba con peticiones HEAD si existen algunos ficheros. Con conexión se
// pregunta a la red y se guarda también el fichero; sin conexión se responde
// según lo que haya en la copia.
async function cabecera(peticion) {
  const cache = await caches.open(CACHE);
  try {
    const respuesta = await fetch(peticion);
    if (respuesta.ok) cache.add(peticion.url).catch(() => {});
    return respuesta;
  } catch (e) {
    const guardada = await cache.match(peticion.url, { ignoreSearch: true });
    if (guardada) return new Response(null, { status: 200, headers: guardada.headers });
    return new Response(null, { status: 404, statusText: "Sin conexión" });
  }
}

self.addEventListener("fetch", (evento) => {
  const peticion = evento.request;
  if (peticion.headers.has("range")) return;
  const url = new URL(peticion.url);
  // Solo este libro: ni otras secciones de la web ni servicios externos (APIs, analítica)
  if (url.origin !== self.location.origin || !url.pathname.startsWith(BASE)) return;
  if (peticion.method === "HEAD") return evento.respondWith(cabecera(peticion));
  if (peticion.method !== "GET") return;
  evento.respondWith(esPagina(peticion, url) ? primeroRed(peticion) : primeroCopia(peticion));
});
