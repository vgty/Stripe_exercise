function displayError(){
  $(".alert").css('display','block');
  $("input[type='submit']").css('display','none');
  $('.input-text').text($(".inputfile").val().replace(/^.*\\/, "").slice(0, 10) + "...");

}
function displaySubmit(){
  $('.input-text').text($(".inputfile").val().replace(/^.*\\/, "").slice(0, 10) + "...");
  $("input[type='submit']").css('display','block');
  $(".alert").css('display','none');
}
$( document ).ready(function(){
    
  $('#browse').click(function(){
    $('.inputfile').trigger('click');
  });
  
  $(".inputfile").change(function(){
    $("#browse").addClass("background");
    if ($(".inputfile").val() != 0){
      if ($('.inputfile').val().match(/.docx|.txt|.pdf/) != null){
        displaySubmit();
      }else {
        displayError();
      }
    }
  });
});
        
      