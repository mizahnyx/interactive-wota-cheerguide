youTubePlayer = null;
wotagei = {};
wotageiÍndices = {}

COMMAND = {
  PAUSE: 1
  PLAY: 2
  SCRIPT: 3
}

alCambiarCanción = ->
  if typeof youTubePlayer is 'object'
    id = $('#cancion').val()
    youTubePlayer.cueVideoById id
  console.log $('#cancion').val(), wotagei
  índice = wotageiÍndices[$('#cancion').val()]
  console.log índice, wotagei[índice]
  if índice
    Module.BrowserQueueSend JSON.stringify [
      COMMAND.SCRIPT,
      wotagei[índice].wotagei
    ]
  
inicializaYouTube = ->
  tag = document.createElement 'script'
  tag.src = 'https://www.youtube.com/iframe_api'
  firstScriptTag = (document.getElementsByTagName 'script')[0]
  console.log (document.getElementsByTagName 'script')[0]
  firstScriptTag.parentNode.insertBefore tag, firstScriptTag

onPlayerStateChange = (event) ->
  console.log event.data, YT.PlayerState
  if event.data == YT.PlayerState.PLAYING
    Module.BrowserQueueSend JSON.stringify [ COMMAND.PLAY ]
  if event.data == YT.PlayerState.PAUSED
    Module.BrowserQueueSend JSON.stringify [ COMMAND.PAUSE ]

onYouTubeIframeAPIReady = () ->
  youTubePlayer = new YT.Player 'youTubePlayer', {
    videoId: $('#cancion').val(),
    events:
      onReady: alCambiarCanción
      onStateChange: onPlayerStateChange
  }
  
#statusElement = document.getElementById('status')
#progressElement = document.getElementById('progress')
#spinnerElement = document.getElementById('spinner')

# Module, required by Emscripten
Module = 
  preRun: []
  postRun: []
  print: do ->
    element = document.getElementById('output')
    if element
      element.value = ''
    # clear browser cache
    (text) ->
      if arguments.length > 1
        text = Array::slice.call(arguments).join(' ')
      # These replacements are necessary if you render to raw HTML
      #text = text.replace(/&/g, "&amp;");
      #text = text.replace(/</g, "&lt;");
      #text = text.replace(/>/g, "&gt;");
      #text = text.replace('\n', '<br>', 'g');
      console.log text
      if element
        element.value += text + '\n'
        element.scrollTop = element.scrollHeight
        # focus on bottom
      return
  printErr: (text) ->
    if arguments.length > 1
      text = Array::slice.call(arguments).join(' ')
    if 0
      # XXX disabled for safety typeof dump == 'function') {
      dump text + '\n'
      # fast, straight to the real console
    else
      console.error text
    return
  canvas: do ->
    canvas = document.getElementById('canvas')
    # As a default initial behavior, pop up an alert when webgl context is lost. To make your
    # application robust, you may want to override this behavior before shipping!
    # See http://www.khronos.org/registry/webgl/specs/latest/1.0/#5.15.2
    canvas.addEventListener 'webglcontextlost', ((e) ->
      alert 'WebGL context lost. You will need to reload the page.'
      e.preventDefault()
      return
    ), false
    canvas
  setStatus: (text) ->
    if !Module.setStatus.last
      Module.setStatus.last =
        time: Date.now()
        text: ''
    if text == Module.setStatus.text
      return
    m = text.match(/([^(]+)\((\d+(\.\d+)?)\/(\d+)\)/)
    now = Date.now()
    if m and now - Date.now() < 30
      return
    # if this is a progress update, skip it if too soon
    #if m
    #  text = m[1]
    #  progressElement.value = parseInt(m[2]) * 100
    #  progressElement.max = parseInt(m[4]) * 100
    #  progressElement.hidden = false
    #  spinnerElement.hidden = false
    #else
    #  progressElement.value = null
    #  progressElement.max = null
    #  progressElement.hidden = true
    #  if !text
    #    spinnerElement.style.display = 'none'
    #statusElement.innerHTML = text
    return
  totalDependencies: 0
  monitorRunDependencies: (left) ->
    @totalDependencies = Math.max(@totalDependencies, left)
    Module.setStatus if left then 'Preparing... (' + @totalDependencies - left + '/' + @totalDependencies + ')' else 'All downloads complete.'
    return

window.onerror = (event) ->
  # TODO: do not warn on ok events like simulating an infinite loop or exitStatus
  Module.setStatus 'Exception thrown, see JavaScript console'
  spinnerElement.style.display = 'none'

  Module.setStatus = (text) ->
    if text
      Module.printErr '[post-exception status] ' + text
    return

  return
  
inicializaCanvas = ->
  do ->
    memoryInitializer = 'interactive-wota-cheerguide.html.mem'
    if typeof Module['locateFile'] == 'function'
      memoryInitializer = Module['locateFile'](memoryInitializer)
    else if Module['memoryInitializerPrefixURL']
      memoryInitializer = Module['memoryInitializerPrefixURL'] + memoryInitializer
    xhr = Module['memoryInitializerRequest'] = new XMLHttpRequest
    xhr.open 'GET', memoryInitializer, true
    xhr.responseType = 'arraybuffer'
    xhr.send null
    return
  script = document.createElement('script')
  script.src = 'interactive-wota-cheerguide.js'
  document.body.appendChild script

inicializaPrueba01 = ->
  $('#test-pause').click ->
    Module.BrowserQueueSend JSON.stringify [ COMMAND.PAUSE ]
  $('#test-play').click ->
    Module.BrowserQueueSend JSON.stringify [ COMMAND.PLAY ]
  $('#test-script').click ->
    data = JSON.stringify [
      COMMAND.SCRIPT
      jsyaml.load($('#test-yaml').val())
    ]
    Module.BrowserQueueSend data

inicializaInterfaz = ->
  # TODO: Cambiar por un timeout que espere la respuesta de BrowserQueueReceive
  $(window).load ->
    $('#loader').fadeOut 3000
  $('#nav-acercade-referencias').on 'click', ->
    $('#modal-referencias').modal 'show'
  $('#nav-acercade-creditos').on 'click', ->
    $('#modal-créditos').modal 'show'
  $('#nav-acercade-historial').on 'click', ->
    $('#modal-historial').modal 'show'
  $('#nav-acercade-notas').on 'click', ->
    $('#modal-notas').modal 'show'

inicializaWotagei = (callback) ->
  $.ajax({
    url: 'data/wotagei.json'
    dataType: 'json'
  }).done (data) ->
    wotagei = data
    $('#cancion').empty()
    wotageiÍndices = {}
    i = 0
    for i in [0...wotagei.length]
      html = "<option value=\"#{wotagei[i].id}\">#{wotagei[i].nombreRomaji} (#{wotagei[i].nombreJaponés})</option>"
      $('#cancion').append html
      wotageiÍndices[wotagei[i].id] = i
    if typeof callback is 'function'
      callback()
  
main = () ->
  inicializaWotagei ->
    inicializaYouTube()
    $('#canción').on 'change', alCambiarCanción
  inicializaCanvas()
  inicializaInterfaz()
  inicializaPrueba01()
  Module.setStatus 'Downloading...'

main()
