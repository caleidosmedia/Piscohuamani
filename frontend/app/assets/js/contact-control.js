$(document).ready(function(){

	var email = document.querySelector('input[type="email"]');
	var name = document.querySelector('input[type="text"]');
	var message = document.querySelector('textarea[name="textarea"]');

	validar(email, "Please enter a valid e-mail address", "This field is required");
	validar(name, "Please enter a valid name", "This field is required");
	validar(message, "Please enter a valid message", "This field is required");

	function validar(inputName, addInformation, invalid) {
		inputName.oninvalid = function(e) {
			e.target.setCustomValidity("");
			if (!e.target.validity.valid) {
				if (e.target.value.length != 0) {
					e.target.setCustomValidity(addInformation);
				} else {
						e.target.setCustomValidity(invalid);
				}
			}
		};
	}
});