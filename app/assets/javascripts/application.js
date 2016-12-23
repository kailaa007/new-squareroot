//= require jquery-ui/datepicker
//= require jquery-ui/sortable
//= require jquery-ui/effect-highlight
//= require fastclick
//= require jquery.cookie
//= require placeholder
//= require foundation.min
//= require imgLiquid
//= require imagesloaded.pkgd
//= require underscore
//= require jquery.slick
//= require misc
//= require entrance
//= require preloader
//= require sortable
//= require slideshow
//= require jquery_nested_form

$(document).foundation();

$(document).ready(function() {
	var value = $( "select option:selected").val();
	
	if(value == 2 || value == 3){
	    $('.phase-fields').css("display", "block");
	}
	else{
	    $('.phase-fields').css("display", "none");
	}

	$('select').on('change', function() {
	    var ques_type =  this.value;
	    if(ques_type==2 || ques_type == 3){
	      $('.phase-fields').css("display", "block");
	    }
	    else{
	      $('.phase-fields').css("display", "none");
	    }    
	}); 

	$(".new_question, .edit_question").submit(function(e){
      var selectOption = $("#question_ques_type").find(":selected").val();
      if(selectOption == 2 || selectOption == 3){
          if($(".option_title:visible").length == 0) {
            alert("Please add option to your question");
            e.preventDefault(e);   
          }    
      }

      $(".fields .option_title:visible").each(function() {
        if($(this).val() == ""){
          alert("Option title cannot be empty");
          $(this).css('border', 'thin solid red');
          e.preventDefault(e);   
        }
      });

    });
});
