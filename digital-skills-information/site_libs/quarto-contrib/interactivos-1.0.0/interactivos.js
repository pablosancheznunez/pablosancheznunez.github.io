/* Interactivos de los libros: ordenar, clasificar, zonas y escenarios.
   Accesibles con teclado y lector de pantalla. Cuando una actividad se
   resuelve, se emite el evento «ia-resuelto» (lo usa el progreso). */
(function () {
  'use strict';
  var EN = (document.documentElement.lang || '').toLowerCase().indexOf('en') === 0;
  function tr(es, en) { return EN ? en : es; }

  function el(tag, attrs, html) {
    var e = document.createElement(tag);
    if (attrs) Object.keys(attrs).forEach(function (k) {
      if (k === 'class') e.className = attrs[k];
      else if (k === 'text') e.textContent = attrs[k];
      else e.setAttribute(k, attrs[k]);
    });
    if (html != null) e.innerHTML = html;
    return e;
  }
  function boton(texto, clase) { return el('button', { type: 'button', class: 'btn btn-sm ' + (clase || 'btn-outline-primary'), text: texto }); }
  function mezclar(a, semilla) {
    var r = a.slice(), s = semilla || 7;
    for (var i = r.length - 1; i > 0; i--) { s = (s * 9301 + 49297) % 233280; var j = Math.floor(s / 233280 * (i + 1)); var t = r[i]; r[i] = r[j]; r[j] = t; }
    return r;
  }
  function hash(t) { var h = 0; for (var i = 0; i < t.length; i++) h = (h * 31 + t.charCodeAt(i)) % 100003; return h + 1; }
  function resuelto(caja) { caja.classList.add('ia-hecho'); document.dispatchEvent(new CustomEvent('ia-resuelto', { detail: caja.id })); }

  function marco(caja, d) {
    caja.innerHTML = '';
    var cab = el('div', { class: 'ia-cabecera' });
    cab.appendChild(el('span', { class: 'ia-etiqueta', text: { ordenar: tr('Ordena', 'Order'), clasificar: tr('Clasifica', 'Classify'), zonas: tr('Elige las zonas', 'Pick the areas'), escenario: tr('Escenario', 'Scenario') }[d.tipo] }));
    if (d.titulo) cab.appendChild(el('span', { class: 'ia-titulo', text: d.titulo }));
    caja.appendChild(cab);
    if (d.enunciado) caja.appendChild(el('div', { class: 'ia-enunciado' }, d.enunciado));
    var cuerpo = el('div', { class: 'ia-cuerpo' });
    caja.appendChild(cuerpo);
    var pie = el('div', { class: 'ia-pie' });
    caja.appendChild(pie);
    var aviso = el('div', { class: 'ia-aviso', role: 'status', 'aria-live': 'polite' });
    caja.appendChild(aviso);
    var expl = el('div', { class: 'ia-explicacion', hidden: '' }, d.explicacion || '');
    caja.appendChild(expl);
    return { cuerpo: cuerpo, pie: pie, aviso: aviso, expl: expl };
  }

  /* ------------------------------------------------------------ ordenar */
  function ordenar(caja, d) {
    var m = marco(caja, d);
    var n = d.items.length;
    var orden = mezclar(d.items.map(function (_, i) { return i; }), hash(caja.id));
    if (orden.every(function (v, i) { return v === i; })) orden.reverse();
    var lista = el('ol', { class: 'ia-lista' });
    m.cuerpo.appendChild(lista);
    var arrastrado = null;

    function pintar(foco) {
      lista.innerHTML = '';
      orden.forEach(function (idx, pos) {
        var li = el('li', { class: 'ia-item', draggable: 'true', 'data-idx': idx });
        li.appendChild(el('span', { class: 'ia-asa', 'aria-hidden': 'true', text: '⠿' }));
        var texto = el('span', { class: 'ia-texto' }, d.items[idx]);
        li.appendChild(texto);
        var plano = texto.textContent.trim();
        var sube = boton('↑', 'btn-outline-secondary ia-mover'); sube.setAttribute('aria-label', tr('Subir: ', 'Move up: ') + plano); sube.disabled = pos === 0;
        var baja = boton('↓', 'btn-outline-secondary ia-mover'); baja.setAttribute('aria-label', tr('Bajar: ', 'Move down: ') + plano); baja.disabled = pos === n - 1;
        sube.addEventListener('click', function () { mover(pos, pos - 1, 'sube'); });
        baja.addEventListener('click', function () { mover(pos, pos + 1, 'baja'); });
        li.appendChild(sube); li.appendChild(baja);
        li.addEventListener('dragstart', function (e) { arrastrado = pos; li.classList.add('ia-arrastrando'); e.dataTransfer.effectAllowed = 'move'; try { e.dataTransfer.setData('text/plain', String(pos)); } catch (x) {} });
        li.addEventListener('dragend', function () { li.classList.remove('ia-arrastrando'); });
        li.addEventListener('dragover', function (e) { e.preventDefault(); });
        li.addEventListener('drop', function (e) { e.preventDefault(); if (arrastrado !== null && arrastrado !== pos) mover(arrastrado, pos); arrastrado = null; });
        lista.appendChild(li);
        if (foco && foco.pos === pos) (foco.cual === 'sube' && !sube.disabled ? sube : (!baja.disabled ? baja : sube)).focus();
      });
    }
    function mover(de, a, cual) {
      if (a < 0 || a >= n) return;
      var v = orden.splice(de, 1)[0]; orden.splice(a, 0, v);
      m.aviso.textContent = tr('Movido a la posición ', 'Moved to position ') + (a + 1) + tr(' de ', ' of ') + n + '.';
      pintar(cual ? { pos: a, cual: cual } : null);
    }
    pintar();
    var comprobar = boton(tr('Comprobar', 'Check'), 'btn-primary'), solucion = boton(tr('Ver la solución', 'Show solution'));
    solucion.hidden = true;
    m.pie.appendChild(comprobar); m.pie.appendChild(solucion);
    comprobar.addEventListener('click', function () {
      var bien = 0;
      Array.prototype.forEach.call(lista.children, function (li, pos) {
        var ok = orden[pos] === pos;
        if (ok) bien++;
        li.classList.toggle('ia-bien', ok); li.classList.toggle('ia-mal', !ok);
        li.setAttribute('aria-label', (ok ? tr('Bien colocado: ', 'Correct position: ') : tr('Mal colocado: ', 'Wrong position: ')) + li.querySelector('.ia-texto').textContent.trim());
      });
      if (bien === n) { m.aviso.textContent = tr('¡Correcto! Todo está en orden.', 'Correct! Everything is in order.'); m.expl.hidden = false; resuelto(caja); }
      else { m.aviso.textContent = bien + tr(' de ', ' of ') + n + tr(' en su sitio. Revisa los marcados en rojo.', ' in place. Check the items marked in red.'); solucion.hidden = false; }
    });
    solucion.addEventListener('click', function () {
      orden = d.items.map(function (_, i) { return i; }); pintar();
      m.aviso.textContent = tr('Este es el orden correcto.', 'This is the correct order.'); m.expl.hidden = false;
    });
  }

  /* ------------------------------------------------------------ clasificar */
  function clasificar(caja, d) {
    var m = marco(caja, d);
    var orden = mezclar(d.items.map(function (_, i) { return i; }), hash(caja.id));
    var tabla = el('div', { class: 'ia-clasificar-filas', role: 'list' });
    m.cuerpo.appendChild(tabla);
    var filas = [];
    orden.forEach(function (idx, k) {
      var it = d.items[idx];
      var fila = el('div', { class: 'ia-fila', role: 'listitem' });
      var idTexto = caja.id + '-t' + k;
      fila.appendChild(el('div', { class: 'ia-texto', id: idTexto }, it.texto));
      var sel = el('select', { class: 'form-select form-select-sm', 'aria-labelledby': idTexto });
      sel.appendChild(el('option', { value: '', text: 'Elige…' }));
      d.categorias.forEach(function (c) { sel.appendChild(el('option', { value: c, text: c })); });
      fila.appendChild(sel);
      var nota = el('div', { class: 'ia-nota', hidden: '' }, it.explicacion || '');
      fila.appendChild(nota);
      tabla.appendChild(fila);
      filas.push({ fila: fila, sel: sel, it: it, nota: nota });
    });
    var comprobar = boton(tr('Comprobar', 'Check'), 'btn-primary'), solucion = boton(tr('Ver la solución', 'Show solution'));
    solucion.hidden = true;
    m.pie.appendChild(comprobar); m.pie.appendChild(solucion);
    comprobar.addEventListener('click', function () {
      var bien = 0, vacias = 0;
      filas.forEach(function (f) {
        if (!f.sel.value) { vacias++; f.fila.classList.remove('ia-bien', 'ia-mal'); return; }
        var ok = f.sel.value === f.it.categoria;
        if (ok) bien++;
        f.fila.classList.toggle('ia-bien', ok); f.fila.classList.toggle('ia-mal', !ok);
        f.nota.hidden = !(ok && f.it.explicacion);
      });
      if (bien === filas.length) { m.aviso.textContent = tr('¡Correcto! Todo bien clasificado.', 'Correct! Everything is well classified.'); m.expl.hidden = false; resuelto(caja); }
      else { m.aviso.textContent = bien + tr(' de ', ' of ') + filas.length + tr(' bien', ' correct') + (vacias ? ' (' + vacias + tr(' sin responder)', ' unanswered)') : '') + '.'; solucion.hidden = false; }
    });
    solucion.addEventListener('click', function () {
      filas.forEach(function (f) { f.sel.value = f.it.categoria; f.fila.classList.remove('ia-mal'); f.fila.classList.add('ia-bien'); f.nota.hidden = !f.it.explicacion; });
      m.aviso.textContent = tr('Esta es la clasificación correcta.', 'This is the correct classification.'); m.expl.hidden = false;
    });
  }

  /* ------------------------------------------------------------ zonas */
  function zonas(caja, d) {
    var m = marco(caja, d);
    var lienzo = el('div', { class: 'ia-lienzo' });
    var img = el('img', { src: d.imagen, alt: d.alt || '' });
    lienzo.appendChild(img);
    m.cuerpo.appendChild(lienzo);
    var botones = [];
    d.zonas.forEach(function (z, i) {
      var b = el('button', { type: 'button', class: 'ia-zona', 'aria-pressed': 'false', 'aria-label': tr('Zona ', 'Area ') + (i + 1) + ': ' + z.descripcion });
      b.style.left = z.x + '%'; b.style.top = z.y + '%'; b.style.width = z.w + '%'; b.style.height = z.h + '%';
      b.appendChild(el('span', { class: 'ia-zona-num', 'aria-hidden': 'true', text: String(i + 1) }));
      b.addEventListener('click', function () { b.setAttribute('aria-pressed', b.getAttribute('aria-pressed') === 'true' ? 'false' : 'true'); });
      lienzo.appendChild(b);
      botones.push(b);
    });
    var leyenda = el('ol', { class: 'ia-leyenda' });
    d.zonas.forEach(function (z, i) {
      var li = el('li', null, '<span class="ia-desc"></span><div class="ia-nota" hidden></div>');
      li.querySelector('.ia-desc').textContent = z.descripcion;
      li.querySelector('.ia-nota').innerHTML = z.explicacion || '';
      leyenda.appendChild(li);
    });
    m.cuerpo.appendChild(leyenda);
    var comprobar = boton(tr('Comprobar', 'Check'), 'btn-primary'), solucion = boton(tr('Ver la solución', 'Show solution'));
    solucion.hidden = true;
    m.pie.appendChild(comprobar); m.pie.appendChild(solucion);
    function mostrarNotas() { Array.prototype.forEach.call(leyenda.children, function (li, i) { var n = li.querySelector('.ia-nota'); n.hidden = !d.zonas[i].explicacion; li.classList.toggle('ia-bien', d.zonas[i].correcta); }); }
    comprobar.addEventListener('click', function () {
      var aciertos = 0, fallos = 0, total = d.zonas.filter(function (z) { return z.correcta; }).length;
      botones.forEach(function (b, i) {
        var marcado = b.getAttribute('aria-pressed') === 'true', z = d.zonas[i];
        b.classList.remove('ia-bien', 'ia-mal');
        if (marcado && z.correcta) { aciertos++; b.classList.add('ia-bien'); }
        else if (marcado && !z.correcta) { fallos++; b.classList.add('ia-mal'); }
      });
      if (aciertos === total && fallos === 0) { m.aviso.textContent = tr('¡Correcto! Has encontrado las ', 'Correct! You found all ') + total + tr(' zonas.', ' areas.'); mostrarNotas(); m.expl.hidden = false; resuelto(caja); }
      else { m.aviso.textContent = tr('Encontradas ', 'Found ') + aciertos + tr(' de ', ' of ') + total + (fallos ? '; ' + fallos + tr(' elegida', ' chosen') + (fallos > 1 ? tr('s', '') : '') + tr(' por error', ' by mistake') : '') + '.'; solucion.hidden = false; }
    });
    solucion.addEventListener('click', function () {
      botones.forEach(function (b, i) { b.setAttribute('aria-pressed', d.zonas[i].correcta ? 'true' : 'false'); b.classList.remove('ia-mal'); b.classList.toggle('ia-bien', d.zonas[i].correcta); });
      mostrarNotas(); m.aviso.textContent = tr('Las zonas correctas están marcadas.', 'The correct areas are marked.'); m.expl.hidden = false;
    });
  }

  /* ------------------------------------------------------------ escenario */
  function escenario(caja, d) {
    var m = marco(caja, d);
    var camino = el('div', { class: 'ia-camino' });
    m.cuerpo.appendChild(camino);
    var reiniciar = boton(tr('Empezar de nuevo', 'Start again'));
    m.pie.appendChild(reiniciar);
    function ir(id, eleccion) {
      var n = d.nodos[id];
      if (!n) return;
      camino.querySelectorAll('.ia-opciones button').forEach(function (b) { b.disabled = true; });
      if (eleccion) eleccion.classList.add('ia-elegida');
      var paso = el('section', { class: 'ia-paso' + (n.final ? ' ia-final ia-final-' + (n.valor || 'neutro') : ''), tabindex: '-1' });
      var etiqueta = n.final ? ({ bien: tr('Buen final', 'Good ending'), mal: tr('Mal final', 'Bad ending'), regular: tr('Final mejorable', 'Could be better') }[n.valor] || tr('Final', 'Ending')) + ': ' : '';
      paso.appendChild(el('h4', { class: 'ia-paso-titulo', text: etiqueta + n.titulo }));
      paso.appendChild(el('div', { class: 'ia-paso-texto' }, n.texto));
      if (n.opciones && n.opciones.length) {
        var ops = el('div', { class: 'ia-opciones', role: 'group', 'aria-label': tr('Opciones', 'Options') });
        n.opciones.forEach(function (o) {
          var b = el('button', { type: 'button', class: 'btn btn-outline-primary btn-sm' }, o.texto);
          b.addEventListener('click', function () { ir(o.destino, b); });
          ops.appendChild(b);
        });
        paso.appendChild(ops);
      }
      camino.appendChild(paso);
      if (eleccion) paso.focus();
      if (n.final) { m.aviso.textContent = etiqueta + n.titulo; if (n.valor === 'bien') resuelto(caja); }
    }
    reiniciar.addEventListener('click', function () { camino.innerHTML = ''; m.aviso.textContent = ''; ir(d.inicio); });
    ir(d.inicio);
  }

  var TIPOS = { ordenar: ordenar, clasificar: clasificar, zonas: zonas, escenario: escenario };

  /* ------------------------------------------------------------ glosario emergente */
  function glosario() {
    var enlaces = document.querySelectorAll('main a[href*="92-glossary.html#gl-"]');
    if (!enlaces.length || typeof window.tippy !== 'function') return;
    var cache = null;
    function cargar() {
      if (!cache) cache = fetch(enlaces[0].href.split('#')[0]).then(function (r) { return r.text(); })
        .then(function (t) { return new DOMParser().parseFromString(t, 'text/html'); });
      return cache;
    }
    enlaces.forEach(function (a) {
      if (location.pathname.indexOf('92-glossary') !== -1) return;
      var id = a.href.split('#')[1];
      window.tippy(a, {
        content: tr('Cargando…', 'Loading…'), allowHTML: true, maxWidth: 360, interactive: false, theme: 'quarto',
        placement: 'bottom-start', appendTo: function () { return document.body; },
        onShow: function (inst) {
          cargar().then(function (doc) {
            var sec = doc.getElementById(id);
            if (!sec) return;
            var tit = sec.querySelector('h1,h2,h3,h4'), p = sec.querySelector('p');
            inst.setContent('<strong>' + (tit ? tit.textContent : '') + '</strong><br>' + (p ? p.innerHTML.replace(/<a [^>]*>(.*?)<\/a>/g, '$1') : ''));
          }).catch(function () {});
        }
      });
    });
  }

  function iniciar() {
    document.querySelectorAll('.ia').forEach(function (caja) {
      var s = caja.querySelector('script.ia-datos');
      if (!s) return;
      try { var d = JSON.parse(s.textContent); (window.IA_DATOS = window.IA_DATOS || {})[caja.id] = d; TIPOS[d.tipo](caja, d); }
      catch (e) { console.error('interactivo', caja.id, e); }
    });
    glosario();
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', iniciar); else iniciar();
})();
