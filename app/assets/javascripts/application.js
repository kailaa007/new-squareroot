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
//= require best_in_place
//= require jquery-ui
//= require best_in_place.jquery-ui

$(document).foundation();

$(document).ready(function() {
  
  $('input.ques_title').on('keydown', function(event) {
    if (this.selectionStart == 0 && event.keyCode >= 65 && event.keyCode <= 90 && !(event.shiftKey) && !(event.ctrlKey) && !(event.metaKey) && !(event.altKey)) {
       var $t = $(this);
       event.preventDefault();
       var char = String.fromCharCode(event.keyCode);
       $t.val(char + $t.val().slice(this.selectionEnd));
       this.setSelectionRange(1,1);
    }
  });	

  $( ".restlink" ).click(function(){
    setTimeout(function() { 
     var qid = $('#quest').val();
     $('#tr_'+qid).show();
    }, 600);

  });
});

$(document).on('click', '.main-ques-opt', function (e) { 
  $("#res_type").show();
});

$(document).on('click', '.res_opt_type', function (e) { 
	if ($(this).val()== "yes") {
       $("#option-list").show();
	}
	else{
		$("#option-list").hide();
	}
});

$(document).on('click', '#reset_form', function (e) { 
	var quesid = $('div#dialog #preview form#new_birth_plan #quest').val();
	var id = $('tr.base_question .res_opt_type').val();
	$('div#dialog #preview form#new_birth_plan')[0].reset();
	$("table.list-ques tr#tr_"+quesid).hide(); 
	$('div#res_type').hide();
	$("#option-list").hide();
	$("input[type = 'checkbox']").removeAttr("checked");
	$("input[type = 'radio']").removeAttr("checked"); 
    $("#quest").children().removeAttr("selected");
    $("#quest option:nth-child(0)").attr("selected", "selected");

	$.ajax({
      url: '/admin/birth_plans/reset',
      data:  {ques_id: id},
      cache: false,
      type: "post",
      //dataType: "text",
      success: function(bdata){ 
      }, 
    }); 
});

$(document).on('change', '#quest', function (e) { 
  $('#preview table.list-ques tr').hide();
  $('#preview table.list-ques tr').eq(0).show();
  var qid = $(this).val();  
  $('#tr_'+qid).show();
});

$(document).on('submit', '#new_birth_plan', function(e){ 
  if ($('.res_opt_type:checked').val()== "yes") { 
  	   var flag = false; 
        $('tr#option-list td').filter(':has(:checkbox:checked)').each(function(){ 
          flag = true;
      	});
        if (flag == false){ 
        	alert("Please select an option");
        	return false;
        }else{
        	
        }

  	}   
});

$(document).on('click', '.base_question :checkbox', function (e) { 
  if($(this).is(':checked')){
    $(this).closest('tr').next('tr').hide();
  }else{
    $(this).closest('tr').next('tr').show();
  }
});

$(document).ready(function() { 
  //$('.btn-success').attr('disabled', 'disabled'); 

  $('.ques-form').on('click', function(){
    ques_id = $(this).attr("data-ques");
    option_id = $(this).attr('id');
    data =  {ques: ques_id, option: option_id };
    url = '/get_restriction' ;

    optionChecked = false;
    if ($(this).prop('checked')==true) {  
      optionChecked = true;
    } 

    $.ajax({
      url: url,
      data:  data,
      cache: false,
      type: "get",
      //dataType: "text",
      beforeSend: function(bdata){ 
      },

      success: function(json){ 
        //console.log(data1);
        result = $.parseJSON(json);
        var flag = false;
        $.each(result, function(key, value) {  
          //alert("Main Question: " + mainQuesId + "--Base Question: " + baseQuesId); 
          if(key == 0 && value.length > 0){ 
            var mainQuesId = value[key].main_ques_id;
            var baseQuesId = value[key].base_ques_id;

            if(baseQuesId == ques_id){
            //Checking Base Question ID
            //-------------------------
              $('#div_'+mainQuesId+' input:radio').each(function () {
                if ($(this).prop('checked')) { 
                  flag = true; 
                }else{ 
                } 
              });

              if(flag === false){
                $('#div_'+baseQuesId+' input:checkbox').each(function () {
                  $(this).attr('checked', false);
                });
                
                var indx = $('#div_'+mainQuesId).attr('data-indx');
                $('#div_'+baseQuesId+' .found_dend').remove(); 
                $('#div_'+baseQuesId).append('<p class="found_dend" style="color:red;">This question is dependent on question no. '+indx+'</p>');

                return false;
              }else{ 
                var indx = $('#div_'+mainQuesId).attr('data-indx');
                $('#div_'+baseQuesId+' .found_dend').remove(); 
              }  
                
            }else{}
          }else if(key == 1 && value.length > 0){
            var mainQuesId 
            var baseQuesId 
            $.each(value, function(key, value){
              mainQuesId = value.main_ques_id;
              mainOption = value.main_option_id;
              baseQuesId = value.base_ques_id;
              baseQuesStatus = value.ques_status;
              baseOption = value.base_option_id;
              baseOptionStatus = value.option_status;
              if (baseQuesStatus == false){  
                if(mainOption == option_id) {
                  $('#div_'+baseQuesId).hide();
                }
                else{
                  $('#div_'+baseQuesId).show();
                }
              }
              else if(baseOptionStatus == false){ 
                if(mainOption == option_id) {
                  $('#'+option_id).click(function() {
                    
                  });
                  if(optionChecked === true){
                    $('#'+baseOption).parent().hide();   
                  }else{
                    $('#'+baseOption).parent().show();   
                  } 
                }
                else{
                  $('#'+baseOption).parent().show();
                }

              }
              else{
                
              }


            });
          }else{} 

        });

      },
    });
  });

  $(".question-form").hide();

  $("#show-form").click(function() {
    $("#search-form").submit();
    $(".question-form").toggle();
  });

  $('#get-ques').click(function() {
    $("#search-form").submit();
  });

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