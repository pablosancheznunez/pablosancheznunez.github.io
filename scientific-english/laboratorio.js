(function () {
// Controles para los laboratorios (celdas {ojs}) sin dependencias externas:
// funcionan sin conexión y no cargan nada de CDN. Cada función devuelve un
// elemento con .value que emite «input», así que sirve con `viewof`.
// Se carga como script normal (no como módulo: así OJS no pide nada a CDN) y
// expone window.Lab. En un capítulo:  area = window.Lab.area

let contador = 0;
const nuevoId = () => "lab-c" + (++contador) + "-" + Math.random().toString(36).slice(2, 7);

function campo(etiqueta) {
  const caja = document.createElement("div");
  caja.className = "lab-campo mb-2";
  const id = nuevoId();
  const l = document.createElement("label");
  l.className = "form-label";
  l.htmlFor = id;
  l.textContent = etiqueta;
  caja.appendChild(l);
  return { caja, id };
}

function avisar(el) { el.dispatchEvent(new Event("input", { bubbles: true })); }

function conEnvio(caja, control, leer, textoBoton) {
  if (!textoBoton) {
    caja.value = leer();
    control.addEventListener("input", (e) => { e.stopPropagation(); caja.value = leer(); avisar(caja); });
    return caja;
  }
  const b = document.createElement("button");
  b.type = "button";
  b.className = "btn btn-primary btn-sm mt-1";
  b.textContent = textoBoton;
  caja.appendChild(b);
  caja.value = leer();
  control.addEventListener("input", (e) => e.stopPropagation());
  const enviar = () => { caja.value = leer(); avisar(caja); };
  b.addEventListener("click", enviar);
  if (control.tagName === "INPUT") control.addEventListener("keydown", (e) => { if (e.key === "Enter") { e.preventDefault(); enviar(); } });
  return caja;
}

function texto(etiqueta, { value = "", submit = null, placeholder = "" } = {}) {
  const { caja, id } = campo(etiqueta);
  const i = document.createElement("input");
  i.type = "text"; i.id = id; i.className = "form-control form-control-sm"; i.value = value; i.placeholder = placeholder;
  caja.appendChild(i);
  return conEnvio(caja, i, () => i.value, submit);
}

function area(etiqueta, { value = "", rows = 4, submit = null } = {}) {
  const { caja, id } = campo(etiqueta);
  const t = document.createElement("textarea");
  t.id = id; t.rows = rows; t.className = "form-control form-control-sm"; t.value = value;
  caja.appendChild(t);
  return conEnvio(caja, t, () => t.value, submit);
}

function seleccion(etiqueta, opciones, { value = null } = {}) {
  const { caja, id } = campo(etiqueta);
  const s = document.createElement("select");
  s.id = id; s.className = "form-select form-select-sm";
  for (const o of opciones) {
    const [v, t] = Array.isArray(o) ? o : [o, o];
    const op = document.createElement("option"); op.value = v; op.textContent = t; s.appendChild(op);
  }
  if (value !== null) s.value = value;
  caja.appendChild(s);
  return conEnvio(caja, s, () => s.value, null);
}

function rango(etiqueta, [min, max], { step = 1, value = min, formato = (x) => x } = {}) {
  const { caja, id } = campo(etiqueta);
  const fila = document.createElement("div");
  fila.className = "d-flex align-items-center gap-2";
  const r = document.createElement("input");
  r.type = "range"; r.id = id; r.min = min; r.max = max; r.step = step; r.value = value; r.className = "form-range";
  const o = document.createElement("output");
  o.htmlFor = id; o.className = "lab-valor";
  const pinta = () => { o.textContent = formato(+r.value); r.setAttribute("aria-valuetext", String(formato(+r.value))); };
  pinta();
  r.addEventListener("input", pinta);
  fila.appendChild(r); fila.appendChild(o); caja.appendChild(fila);
  return conEnvio(caja, r, () => +r.value, null);
}

function color(etiqueta, { value = "#000000" } = {}) {
  const { caja, id } = campo(etiqueta);
  const fila = document.createElement("div");
  fila.className = "d-flex align-items-center gap-2";
  const c = document.createElement("input");
  c.type = "color"; c.id = id; c.value = value; c.className = "form-control form-control-color";
  const t = document.createElement("input");
  t.type = "text"; t.value = value; t.className = "form-control form-control-sm"; t.style.maxWidth = "7rem";
  t.setAttribute("aria-label", etiqueta + " (código hexadecimal)");
  c.addEventListener("input", () => { t.value = c.value; });
  t.addEventListener("input", (e) => { if (/^#[0-9a-f]{6}$/i.test(t.value)) { c.value = t.value; c.dispatchEvent(new Event("input", { bubbles: true })); } e.stopPropagation(); });
  fila.appendChild(c); fila.appendChild(t); caja.appendChild(fila);
  return conEnvio(caja, c, () => c.value, null);
}

function casilla(etiqueta, { value = false } = {}) {
  const caja = document.createElement("div");
  caja.className = "form-check mb-2";
  const id = nuevoId();
  const c = document.createElement("input");
  c.type = "checkbox"; c.id = id; c.className = "form-check-input"; c.checked = value;
  const l = document.createElement("label");
  l.className = "form-check-label"; l.htmlFor = id; l.textContent = etiqueta;
  caja.appendChild(c); caja.appendChild(l);
  return conEnvio(caja, c, () => c.checked, null);
}

function boton(textoBoton) {
  const caja = document.createElement("div");
  caja.className = "mb-2";
  const b = document.createElement("button");
  b.type = "button"; b.className = "btn btn-outline-primary btn-sm"; b.textContent = textoBoton;
  caja.appendChild(b);
  caja.value = 0;
  b.addEventListener("click", () => { caja.value++; avisar(caja); });
  return caja;
}

window.Lab = { texto, area, seleccion, rango, color, casilla, boton };
})();
