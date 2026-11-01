// Cookie consent. Google Analytics and Microsoft Clarity load only after the visitor accepts;
// nothing is loaded or stored before that. The choice is kept in localStorage.
(function () {
  var KEY = 'cookie-consent';
  var GA_ID = 'G-1JPMKM4GKT';
  var CLARITY_ID = 'z70t7aryz2';

  function getChoice() {
    try { return localStorage.getItem(KEY); } catch (e) { return null; }
  }
  function setChoice(value) {
    try { localStorage.setItem(KEY, value); } catch (e) {}
  }

  function loadScript(src) {
    var s = document.createElement('script');
    s.async = true;
    s.src = src;
    document.head.appendChild(s);
  }

  function loadAnalytics() {
    // Google tag (gtag.js)
    window.dataLayer = window.dataLayer || [];
    window.gtag = function () { dataLayer.push(arguments); };
    gtag('js', new Date());
    gtag('config', GA_ID);
    loadScript('https://www.googletagmanager.com/gtag/js?id=' + GA_ID);

    // Microsoft Clarity
    window.clarity = window.clarity || function () { (window.clarity.q = window.clarity.q || []).push(arguments); };
    window.clarity('consent');
    loadScript('https://www.clarity.ms/tag/' + CLARITY_ID);
  }

  // Removes the cookies Google Analytics and Clarity set, on this host and its parent domain.
  function clearAnalyticsCookies() {
    var host = location.hostname;
    var domains = ['', host, '.' + host.replace(/^www\./, '')];
    document.cookie.split(';').forEach(function (c) {
      var name = c.split('=')[0].trim();
      if (/^(_ga|_gid|_gat|_clck|_clsk|CLID|ANONCHK|MR|MUID|SM)/.test(name)) {
        domains.forEach(function (d) {
          document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/' + (d ? '; domain=' + d : '');
        });
      }
    });
  }

  var css =
    '.cookie-banner{position:fixed;left:16px;right:16px;bottom:16px;z-index:20;max-width:560px;margin:0 auto;' +
    'background:var(--bg,#fff);color:var(--ink,#1a1a1a);border:1px solid var(--hair,#ddd);border-radius:4px;' +
    'box-shadow:0 4px 18px rgba(0,0,0,.12);padding:16px 18px;font-family:var(--font,Georgia,serif);font-size:15px;line-height:1.5}' +
    '.cookie-banner p{margin:0 0 12px;max-width:none}' +
    '.cookie-actions{display:flex;gap:10px;flex-wrap:wrap}' +
    '.cookie-actions button{font:inherit;font-size:14px;padding:5px 16px;border-radius:3px;cursor:pointer;' +
    'border:1px solid var(--ink,#1a1a1a);background:var(--bg,#fff);color:var(--ink,#1a1a1a)}' +
    '.cookie-actions button:hover{border-color:var(--link,#1a4d8f);color:var(--link,#1a4d8f)}' +
    '.cookie-settings{font:inherit;color:inherit;background:none;border:none;padding:0;text-decoration:underline;' +
    'text-underline-offset:2px;cursor:pointer}' +
    '@media print{.cookie-banner{display:none}}';

  var banner;
  function showBanner() {
    if (banner) { banner.hidden = false; banner.querySelector('button').focus(); return; }
    var style = document.createElement('style');
    style.textContent = css;
    document.head.appendChild(style);

    banner = document.createElement('div');
    banner.className = 'cookie-banner';
    banner.setAttribute('role', 'region');
    banner.setAttribute('aria-label', 'Cookie consent');
    banner.innerHTML =
      '<p>This site uses cookies from Google Analytics and Microsoft Clarity to understand how visitors use it. ' +
      'They are only set if you accept, and you can change your choice at any time. ' +
      '<a href="/cookies.html">Cookie policy</a></p>' +
      '<div class="cookie-actions"><button type="button" data-consent="granted">Accept</button>' +
      '<button type="button" data-consent="denied">Reject</button></div>';
    banner.addEventListener('click', function (e) {
      var value = e.target.getAttribute('data-consent');
      if (!value) return;
      var previous = getChoice();
      setChoice(value);
      banner.hidden = true;
      if (value === 'granted' && previous !== 'granted') loadAnalytics();
      if (value === 'denied' && previous === 'granted') {
        // Stop both tags first so they don't write their cookies again before the reload.
        window['ga-disable-' + GA_ID] = true;
        if (window.clarity) window.clarity('consent', false);
        clearAnalyticsCookies();
        location.reload();
      }
    });
    document.body.appendChild(banner);
  }

  var choice = getChoice();
  if (choice === 'granted') loadAnalytics();
  else clearAnalyticsCookies();

  document.addEventListener('DOMContentLoaded', function () {
    if (choice !== 'granted' && choice !== 'denied') showBanner();
    document.querySelectorAll('[data-cookie-settings]').forEach(function (b) {
      b.addEventListener('click', showBanner);
    });
  });
})();
