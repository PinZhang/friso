(function() {

  function $(id) {
    return document.getElementById(id);
  }

  if (typeof Module == 'undefined') Module = {};

  if (typeof Module['setStatus'] == 'undefined') {
    Module['setStatus'] = function (status) {
      $('status').textContent = status;
    };
  }

  if (typeof Module['canvas'] == 'undefined') {
    Module['canvas'] = $('canvas');
  }

  function getLoggerTime() {
    var date = new Date();
    return date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + ":" + date.getMilliseconds();
  }

  var MAX_LOG_NUM = 20;

  function log(msg) {
    var parent = $('log');
    if (parent.childNodes.length > MAX_LOG_NUM) {
      parent.removeChild(parent.childNodes[0]);
    }

    if (typeof msg == 'string') {
      var logElem = document.createElement('div');
      logElem.textContent = getLoggerTime() + ": " + msg;
      parent.appendChild(logElem);
    } else {
      parent.appendChild(msg);
    }
  }

  function clearLog() {
    $('log').textContent = '';
  }

  if (!Module['_main']) Module['_main'] = function() {
    log("All files are loaded!");

    var fr_seg = Module.cwrap('fr_seg', '', ['string']);
    var fr_next = Module.cwrap('fr_next', 'string', []);
    var fr_free = Module.cwrap('fr_free', '', []);

    function segment() {
      fr_seg($('cn_text').value.trim());

      var str = null;
      while (str = fr_next()) {
        log(str);
      }

      fr_free();
    }

    $('segment').onclick = segment;
    $('clear_log').onclick = clearLog;
  }

})();

