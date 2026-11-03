// Package filter and copy buttons. The page works without this script.
(function () {
  var filter = document.getElementById('filter');
  if (filter) {
    var items = Array.prototype.slice.call(document.querySelectorAll('#software .item'));
    var groups = Array.prototype.slice.call(document.querySelectorAll('#software .group'));
    var count = document.getElementById('count');
    var empty = document.getElementById('empty');
    var update = function () {
      var term = filter.value.trim().toLowerCase();
      var shown = 0;
      items.forEach(function (li) {
        var hit = !term || li.textContent.toLowerCase().indexOf(term) !== -1;
        li.hidden = !hit;
        if (hit) shown++;
      });
      groups.forEach(function (g) { g.hidden = !g.querySelector('.item:not([hidden])'); });
      count.textContent = term ? shown + ' of ' + items.length + ' packages' : items.length + ' packages';
      empty.hidden = shown > 0;
    };
    filter.addEventListener('input', update);
  }

  document.querySelectorAll('.copy-btn').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var text = btn.getAttribute('data-copy');
      var done = function (ok) {
        var original = btn.textContent;
        btn.textContent = ok ? 'Copied' : 'Select & copy';
        setTimeout(function () { btn.textContent = original; }, 1500);
      };
      if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(text).then(function () { done(true); }, function () { done(false); });
      } else {
        done(false);
      }
    });
  });

  // Remove the old offline cache, which kept showing visitors an outdated copy of the site.
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.getRegistrations().then(function (regs) {
      regs.forEach(function (r) { if (new URL(r.scope).pathname === '/') r.unregister(); });
    }).catch(function () {});
  }
})();
