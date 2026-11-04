// Copy button for the email address. The page works without this script.
(function () {
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
