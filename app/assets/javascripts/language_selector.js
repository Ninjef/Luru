var languageSelector = document.getElementById("language-dropdown");

    function changeLanguageParam() {
      var url=window.location.href;
      selectedLanguage = languageSelector.value

      urlWithoutLanguageParam = url.replace(/(language=\w*|\&language=\w*)/,"");
      separator = (url.indexOf("?") === -1)? "?" : "&";
      newUrl = urlWithoutLanguageParam + separator + "language=" + selectedLanguage;
      cleanNewUrl = newUrl.replace("?&","?");
      window.location.href = cleanNewUrl;
    }
