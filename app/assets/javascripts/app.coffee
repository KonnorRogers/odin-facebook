@dropDown ->
  $("dropdown").classList.toggle("show")

# close the dropdown if clicked outside of the dropdown
window.onclick = (e) ->
  return unless (!e.target.matches('.dropbtn'))

  myDropdown = $("dropdown")
  return unless myDropdown.classList.contains('show')
      myDropdown.classList.remove('show')


