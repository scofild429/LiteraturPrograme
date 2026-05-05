(function() {
    function init() {
        var toc = document.getElementById('table-of-contents');
        if (!toc) return;

        // Remove the "Table of Contents" heading
        var h2 = toc.querySelector('h2');
        if (h2) h2.remove();

        // Build sidebar DOM
        var sidebar = document.createElement('aside');
        sidebar.className = 'toc-sidebar';
        var header = document.createElement('div');
        header.className = 'toc-sidebar-header';
        var titleSpan = document.createElement('span');
        titleSpan.textContent = 'On this page';
        var closeBtn = document.createElement('button');
        closeBtn.className = 'toc-sidebar-close';
        closeBtn.title = 'Close TOC';
        closeBtn.innerHTML = '&times;';
        header.appendChild(titleSpan);
        header.appendChild(closeBtn);
        var contentWrap = document.createElement('div');
        contentWrap.className = 'toc-sidebar-content';
        sidebar.appendChild(header);
        sidebar.appendChild(contentWrap);

        // Build toggle button (visible when sidebar is closed)
        var toggleBtn = document.createElement('button');
        toggleBtn.className = 'toc-sidebar-toggle';
        toggleBtn.title = 'Show table of contents';
        toggleBtn.innerHTML = '&#9776;';

        // Move TOC into sidebar
        contentWrap.appendChild(toc);
        document.body.appendChild(sidebar);
        document.body.appendChild(toggleBtn);
        document.body.classList.add('toc-visible');

        // Fix TOC link hrefs and add smooth-scroll click handlers
        var links = toc.querySelectorAll('a');
        var linkMap = {};
        links.forEach(function(a) {
            var href = a.getAttribute('href');
            if (href && href.indexOf('#') !== -1) {
                var hash = href.split('#')[1];
                if (hash) {
                    a.setAttribute('href', '#' + hash);
                    linkMap[hash] = a;
                }
                a.addEventListener('click', function(e) {
                    e.preventDefault();
                    // Scroll to target heading
                    if (hash) {
                        var target = document.getElementById(hash);
                        if (target) {
                            target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                            history.replaceState(null, null, '#' + hash);
                        }
                    }
                    // Highlight clicked link
                    links.forEach(function(l) { l.classList.remove('active'); });
                    a.classList.add('active');
                });
            }
        });

        // --- Scroll-spy ---
        var headings = document.querySelectorAll('h2[id], h3[id], h4[id]');
        if (!headings.length) return;

        var ticking = false;
        window.addEventListener('scroll', function() {
            if (!ticking) {
                requestAnimationFrame(function() {
                    updateActiveHeading();
                    ticking = false;
                });
                ticking = true;
            }
        }, { passive: true });

        function updateActiveHeading() {
            var scrollTop = window.scrollY || document.documentElement.scrollTop;
            var currentId = null;

            for (var i = 0; i < headings.length; i++) {
                var rect = headings[i].getBoundingClientRect();
                if (rect.top <= 80) {
                    currentId = headings[i].id;
                } else {
                    break;
                }
            }

            if (!currentId && headings.length > 0) {
                currentId = headings[0].id;
            }

            links.forEach(function(l) { l.classList.remove('active'); });
            if (currentId && linkMap[currentId]) {
                linkMap[currentId].classList.add('active');
                linkMap[currentId].scrollIntoView({ block: 'center', behavior: 'smooth' });
            }
        }

        // Initial call
        updateActiveHeading();

        // --- Toggle ---
        closeBtn.addEventListener('click', function() {
            sidebar.classList.add('hidden');
            toggleBtn.classList.add('visible');
            document.body.classList.remove('toc-visible');
        });

        toggleBtn.addEventListener('click', function() {
            sidebar.classList.remove('hidden');
            toggleBtn.classList.remove('visible');
            document.body.classList.add('toc-visible');
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
