alCambiarCanción = () ->
  document.write 'patito!<br>'
  
inicializaYouTube = () ->
  tag = document.createElement 'script'
  tag.src = 'https://www.youtube.com/iframe_api'
  firstScriptTag = (document.getElementsByTagName 'script')[0]
  console.log (document.getElementsByTagName 'script')[0]
  firstScriptTag.parentNode.insertBefore tag, firstScriptTag

youTubePlayer = null;

onYouTubeIframeAPIReady = () ->
  youTubePlayer = new YT.Player 'youTubePlayer', {
    videoId: (document.getElementById 'cancion').value,
    events: {}
  }
  
main = () ->
  inicializaYouTube()

main()
