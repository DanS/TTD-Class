function remove_fields(link){
  debugger;
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}