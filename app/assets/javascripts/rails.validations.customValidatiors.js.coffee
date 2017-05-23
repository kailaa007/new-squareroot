$confirmationField =
$element =
handleBlur = ->
  $confirmationField.data "blurredOnce", true
  $element.data "changed", true
  $element.isValid $element[0].form.ClientSideValidations.settings.validators

ClientSideValidations.validators.local.confirmation = (element, options) ->
  $element = element
  $confirmationField = $("#" + (element.attr('id')) + "_confirmation")
  $confirmationField.off("blur",handleBlur).on("blur",handleBlur)
  if ($confirmationField.data("blurredOnce") && $element.val() != $confirmationField.val())
    return options.message
  return