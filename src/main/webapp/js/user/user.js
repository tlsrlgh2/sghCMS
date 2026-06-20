(function () {
    "use strict";

    var topButton = document.getElementById("pageTopBtn");

    if (topButton) {
        topButton.addEventListener("click", function () {
            window.scrollTo({ top: 0, behavior: "smooth" });
        });
    }

    var visualCarousel = document.getElementById("mainVisualCarousel");
    var visualCounter = document.querySelector(".visual-controls span strong");

    if (visualCarousel && visualCounter) {
        visualCarousel.addEventListener("slid.bs.carousel", function (event) {
            visualCounter.textContent = String(event.to + 1).padStart(2, "0");
        });
    }
}());
function initializeMainPopups() {
  const layer = document.getElementById("youthPopupLayer");
  if (!layer) {
    return;
  }

  const popups = Array.from(layer.querySelectorAll(".youth-popup-card")).filter((popup) => {
    return localStorage.getItem(`sghcms-popup-${popup.dataset.popupId}`) !== todayKey();
  });
  let currentIndex = 0;

  function todayKey() {
    const now = new Date();
    return `${now.getFullYear()}-${now.getMonth() + 1}-${now.getDate()}`;
  }

  function showCurrentPopup() {
    layer.hidden = currentIndex >= popups.length;
    document.body.classList.toggle("popup-layer-open", !layer.hidden);
    popups.forEach((popup, index) => {
      popup.hidden = index !== currentIndex;
    });
    if (!layer.hidden) {
      popups[currentIndex].querySelector("[data-popup-close]")?.focus();
    }
  }

  function closeCurrentPopup() {
    const popup = popups[currentIndex];
    if (!popup) {
      return;
    }
    if (popup.querySelector("[data-popup-hide-today]")?.checked) {
      localStorage.setItem(`sghcms-popup-${popup.dataset.popupId}`, todayKey());
    }
    currentIndex += 1;
    showCurrentPopup();
  }

  popups.forEach((popup) => {
    const popupUrl = (popup.dataset.popupUrl || "").trim();
    const linkButton = popup.querySelector("[data-popup-link]");
    const safeUrl = popupUrl.startsWith("/") || /^https?:\/\//i.test(popupUrl);
    if (linkButton && safeUrl) {
      linkButton.classList.add("is-linked");
      linkButton.addEventListener("click", () => {
        window.location.href = popupUrl;
      });
    }
  });

  layer.querySelectorAll("[data-popup-close]").forEach((button) => {
    button.addEventListener("click", closeCurrentPopup);
  });
  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && !layer.hidden) {
      closeCurrentPopup();
    }
  });

  showCurrentPopup();
}

document.addEventListener("DOMContentLoaded", initializeMainPopups);
