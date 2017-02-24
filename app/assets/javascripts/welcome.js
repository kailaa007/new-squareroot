
    jQuery(document).ready(function(){
        getpopupHeight();
        jQuery("#duedate-cal").datepicker();
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
            var getChecklistPopupH = jQuery("#checklist-popup").innerHeight()/2;
            jQuery("#checklist-popup").css("marginTop", -getTermofusePopupH);
            var getConfirmationPopupH = jQuery("#confirmation-popup").innerHeight()/2;
            jQuery("#confirmation-popup").css("marginTop", -getConfirmationPopupH);
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
        jQuery(".checklist-link").on("click", function(){
            jQuery("#checklist-popup").addClass("showchecklist");
            jQuery(".common-overlay").show();
        });
        jQuery(".close-checklist-form").on("click", function(){
           jQuery("#checklist-popup").removeClass("showchecklist"); 
           jQuery(".common-overlay").hide();
        });
        jQuery(".nxt-btn").on("click", function(){
            jQuery(".common-overlay, #confirmation-popup").fadeIn();
            
        });
        jQuery(".close-confirmation-form").on("click", function(){
            jQuery("#confirmation-popup, .common-overlay").fadeOut();
            
        });

        var addFiles = '<li>';
            addFiles +='<input type="text" name="question-1" class="options small" id="option3-1">' ;                                       
            addFiles +='<input type="text" name="question-1" class="options small" id="option3-1">';
            addFiles +='<label class="add_multiple_fields"><a class="add_fields" href="javascript:void(0);" title=""></a></label>';
            addFiles +='<a class="add_fields mobile btn" href="javascript:void(0);" title="">Add</a>'
            addFiles +='</li>';
        jQuery(document).on("click", ".add_fields", function(){
            jQuery(this).closest("ul").append(addFiles);
            jQuery(this).css("display", "none");
        });        
    });