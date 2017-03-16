//= require jquery-ui
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
//= require best_in_place.jquery-ui
//= require jquery.custom-scrollbar
//= require rails.validations
//= require rails.validations.simple_form
//= require rails.validations.customValidatiors
//= require welcome
//= require jquery.validationEngine.js
//= require jquery.validationEngine-en.js
//= require jquery.alphanum.js
//= require print.min.js

$(document).foundation();

$(document).ready(function() {

  
  $( ".datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
  
  
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

$(document).on('click', '.cls_modal', function (e) { 
  var dataTarget = $(this).attr('data-target');
  $("div.modal-backdrop").remove();
  $('body.birth_plans').removeClass('modal-open');
  $('body.birth_plans').css('padding-right', '');
 
  $('div.modal.fade').each(function(index, item) { 
    var currID = $(this).attr('id'); 
    if(dataTarget == '#'+currID){   
      $('body.birth_plans').addClass('modal-open');
      $('body.birth_plans').css('padding-right', '14px');
      $("body.birth_plans").append('<div class="modal-backdrop fade in"></div>');
      $('div#'+currID).addClass('in'); 
      $('div#'+currID).css('display', 'block'); 
    }else{ 
      $('div#'+currID).removeClass('in'); 
      $('div#'+currID).css('display', 'none'); 
    }
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
  
  $('form#new_question').submit(function(){
    var qesTitle = $('#question_title').val();
    var qesType = $('#question_ques_type').val();
    var flag = false;
    if(qesTitle == ""){
      $('#question_title').css('border', '1px solid red');
      flag = true;
    }else{
      $('#question_title').css('border', '1px solid #cccccc');
    }

    if(qesType == ""){
      $('#question_ques_type').css('border', '1px solid red');
      flag = true;
    }else{
      $('#question_ques_type').css('border', '1px solid #cccccc');
    }

    if(flag === true){
      return false;
    } 
  });

  $('form.edit_question').submit(function(){
    var qesTitle = $('#question_title').val();
    var qesType = $('#question_ques_type').val();
    var flag = false;
    if(qesTitle == ""){
      $('#question_title').css('border', '1px solid red');
      flag = true;
    }else{
      $('#question_title').css('border', '1px solid #cccccc');
    }

    if(qesType == ""){
      $('#question_ques_type').css('border', '1px solid red');
      flag = true;
    }else{
      $('#question_ques_type').css('border', '1px solid #cccccc');
    }

    if(flag === true){
      return false;
    } 
  });

  /*$( "table.index-list_111 tbody#questions_111" ).sortable( {
    update: function( event, ui ) { 
      //$(this).children().each(function(index) {  
        //$(this).find('td').last().html(index + 1)
      //});
    },
    stop: function (event, ui) {  
        var p = $('.not').offset().top; 
        var Q = ui.position.top;

        p = Math.round(p);
        Q = Math.round(Q);
         
        if (Q < p) {
          $('#sort_errors').html('<p style="color:red; font-size: 13px;margin-bottom: 0px;">You can not move. First you have to remove the restrictions and then try again.</p>').fadeIn();
          setTimeout(function(){ $('#sort_errors').html('').fadeOut(); }, 3000);
          return false;
        }else{ 
          var flag1 = false;
          var flag2 = false;
          $('table.index-list tr').each(function() {
             var clsTR = $(this).attr('class');
             if(clsTR != ''){
              if(clsTR == 'enable'){
                flag1 = true;
              }
              if(flag1 === true && clsTR == 'not'){
                flag2 = true;
              }
             } 
          });
          if(flag1 === true && flag2 === true){
            $('#sort_errors').html('<p style="color:red; font-size: 13px;margin-bottom: 0px;">You can not move. First you have to remove the restrictions and then try again.</p>').fadeIn();
            setTimeout(function(){ $('#sort_errors').html('').fadeOut(); }, 3000);
            return false;
          }else{  
            //alert($(this).html());
            var strSort = '{';
            var orderArray = [];
            var quesidArray = [];
            $('table.index-list tr').each(function(index) {
               var clsTR = $(this).attr('class');
               var dataidTR = $(this).attr('data-id'); 
                if(clsTR == 'enable' && dataidTR != ""){ 
                  //var data_id = parseInt($(this).attr('data-id')); 
                  orderArray.push(index);
                  quesidArray.push(dataidTR);
                }else{
                   
                } 
            });    
            $.ajax({
              url: '/admin/birth_plans/sort',
              cache: false,
              type: "post",
              dataType: 'json',
              contentType: 'application/json',
              //  Parameters: {"sort"=>{"40"=>"3", "41"=>"5", "42"=>"4"}}
              
              data: JSON.stringify({ques_order: orderArray, ques_id: quesidArray}),
              //dataType: "text",
              success: function(bdata){ 
                alert('done');
              },
            });
          }
        }
    },
    cancel: '.not'
  });*/
 

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

               $('#div_'+mainQuesId+' input:checkbox').each(function () {
                if ($(this).prop('checked')) { 
                  flag = true; 
                }else{ 
                } 
              });

              if(flag === false){
                $('#div_'+baseQuesId+' input:checkbox').each(function () {
                  $(this).attr('checked', false);
                });
                
                $('#div_'+baseQuesId+' input:radio').each(function () {
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
                  //$('#div_'+baseQuesId).hide();  
                  if(optionChecked === true){
                    $('#div_'+baseQuesId).hide();  
                  }else{
                    $('#div_'+baseQuesId).show();   
                  } 
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

	$('#question_ques_type').on('change', function() {
	    var ques_type =  this.value;
	    if(ques_type==2 || ques_type == 3){
	      $('.phase-fields').css("display", "block");
	    }
	    else{
	      $('.phase-fields').css("display", "none");
	    }    
	}); 

  var eqt = $('form.edit_question #question_ques_type').val();
  if(eqt != '' && eqt != 'undefined'){  
    if(eqt == 2 || eqt == 3){ 
      $('#question_ques_type').trigger('change'); 
    } 
  } 

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

jQuery(document).ready(function(){

  jQuery("#frmSignUp_123").click(function(){
    var user_first_name = jQuery("#user_first_name").val();
    var user_last_name = jQuery("#user_last_name").val();
    var user_email = jQuery("#user_email").val();
    var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    var user_password = jQuery("#user_password").val();
    var user_password_confirmation = jQuery("#user_password_confirmation").val();
    var user_zipcode = jQuery("#user_zipcode").val();
    var user_due_date = jQuery("#user_due_date").val();
    var iAgree = jQuery("#iAgree").val();
    
    var flag = false;

    if(user_first_name == ""){
      jQuery("#user_first_name").css("border", "1px solid red");
      flag = true;
    }else{
      jQuery("#user_first_name").css("border", "1px solid #969696");
    }

    if(user_last_name == ""){
      jQuery("#user_last_name").css("border", "1px solid red");
      flag = true;
    }else{
      jQuery("#user_last_name").css("border", "1px solid #969696");
    }

    if(user_email == ""){
      jQuery("#user_email").css("border", "1px solid red");
      flag = true;
    }else{
      if(!regex.test(user_email)){
        jQuery("#user_email").css("border", "1px solid red");
        flag = true;
      }else{
        jQuery("#user_email").css("border", "1px solid #969696");
      } 
    }

    if(user_password == ""){
      jQuery("#user_password").css("border", "1px solid red");
      flag = true;
    }else{
      jQuery("#user_password").css("border", "1px solid #969696");
    }

    if(user_password_confirmation == ""){
      jQuery("#user_password_confirmation").css("border", "1px solid red");
      flag = true;
    }else{
      jQuery("#user_password_confirmation").css("border", "1px solid #969696");
    }

    if(user_password != "" && user_password_confirmation != ""){
      if(user_password != user_password_confirmation){
        jQuery("#user_password").css("border", "1px solid red");
        jQuery("#user_password_confirmation").css("border", "1px solid red");
        flag = true;
      }else{
        jQuery("#user_password").css("border", "1px solid #969696");
        jQuery("#user_password_confirmation").css("border", "1px solid #969696");
      }
    }

    if(user_zipcode == ""){
      jQuery("#user_zipcode").css("border", "1px solid red");
      flag = true;
    }else{
      jQuery("#user_zipcode").css("border", "1px solid #969696");
    }

    if(user_due_date == ""){
      jQuery("#user_due_date").css("border", "1px solid red");
      flag = true;
    }else{
      jQuery("#user_due_date").css("border", "1px solid #969696");
    }

    if($("#iAgree").is(':checked')){ 
      //jQuery("#iAgree").css("border", "1px solid red");
      flag = true;
    }else{ 
      //jQuery("#iAgree").css("border", "1px solid #969696");
    }

    if(flag === true){
      return false;
    }
    
  });

  getpopupHeight();
  jQuery("#user_due_date").datepicker();

  jQuery("#loginForm input").keydown(function(){
      if(jQuery(this).val() != '') {
          jQuery(this).addClass("datafill")
      }
  });

  jQuery(document).on("click",function(){
      var getFormsPopupH = jQuery("#forms-popup").innerHeight()/2;
      jQuery("#forms-popup").css("marginTop", -getFormsPopupH);
      var getTermofusePopupH = jQuery("#termofuse-popup").innerHeight()/2;
      jQuery("#termofuse-popup").css("marginTop", -getTermofusePopupH);
  });

  jQuery("#getStarted").on("click", function(){
      jQuery("#forms-popup, .login-form").fadeIn();
  });

  jQuery(".sign-up-link").on("click", function(){
      jQuery(".login-form").hide();
      jQuery(".sign-up-form").fadeIn();
  });

  jQuery(".login-link").on("click", function(){
      jQuery(".sign-up-form").hide();
      jQuery(".login-form").fadeIn();
  });

  jQuery(".close-login-form, .close-signup-form").on("click", function(){
      jQuery("#forms-popup, .sign-up-form").hide();
      jQuery(".login-form").fadeIn();
  });

  jQuery(".termsofuse-link").on("click", function(){
      jQuery("#forms-popup, .sign-up-form").hide();
      jQuery(".login-form").fadeIn();
      jQuery("#termofuse-popup").addClass("showtermofuse");
  });

  jQuery(".close-termofuse-form").on("click", function(){
      jQuery("#termofuse-popup").removeClass("showtermofuse");
  });

  jQuery(".back-termofuse-form").on("click", function(){  
      jQuery("#termofuse-popup").removeClass("showtermofuse");          
      jQuery(".login-form").hide();
      jQuery("#forms-popup, .sign-up-form").fadeIn();
  });

  jQuery(".frgt-pswd-link").on("click", function(){
      jQuery(".login-form").hide();
      jQuery(".forget-pswd-form").fadeIn();
  });

  jQuery(".close-forget-pswd-form").on("click", function(){
      jQuery("#forms-popup, .forget-pswd-form").hide();

  });
});

jQuery(window).resize(function(){
  getpopupHeight();
})

function getpopupHeight() {
  var getpopupH = jQuery("#birth-intro-popup").innerHeight()/2;  
  jQuery("#birth-intro-popup").css("marginTop",  -getpopupH);
  var getFormsPopupH = jQuery("#forms-popup").innerHeight()/2;
  jQuery("#forms-popup").css("marginTop", -getFormsPopupH);
  
  $(".ques_info, .help").hover(function() {
      // var getTooltipBoxH = jQuery(this).find(".tooltip_box").innerHeight()/2;
      // jQuery(this).find(".tooltip_box").css("bottom", -getTooltipBoxH-4);
      jQuery(this).find(".tooltip_box").addClass("showtooltipbox")
  },
  function() {
      jQuery(this).find(".tooltip_box").removeClass("showtooltipbox")
  });
}

function closePopup() {
  $('#signUpForm')[0].reset();
  $('#loginForm')[0].reset();
  $('#forgetPasswordForm')[0].reset();
  $(".formError").remove();
  $('input').removeClass('input-box-error');
  $('email').removeClass('input-box-error');
  $('#terms-form-signup').removeClass('input-box-error');
}

$("#user_zipcode").numeric({
    allowSpace: false, 
    maxDigits: 5
  });

$("#password").alphanum({
    allowSpace: false, 
    allow :    '~!@#$%^&*()_+{}:">?<,./;'
  });

$("#user_password_confirmation").alphanum({
    allowSpace: false, 
    allow :    '~!@#$%^&*()_+{}:">?<,./;'
  });

$("#user_password").alphanum({
    allowSpace: false, 
    allow :    '~!@#$%^&*()_+{}:">?<,./;'
  });

$("#user_first_name").alpha({
    allowSpace: true, 
    maxLength: 25
  });
$("#user_last_name").alpha({
    allowSpace: true, 
    maxLength: 25
  });

$('#signUpForm').submit(function() {
  if ($("#iAgree").is(':checked') == false){
    $("#terms-form-signup").addClass("input-box-error");
  };
});

$('#iAgree').on("click", function(){
  if ($("#iAgree").is(':checked') == true){
    $("#terms-form-signup").removeClass("input-box-error");
  }
  else{
    $("#terms-form-signup").addClass("input-box-error");
  }
  ;

})
