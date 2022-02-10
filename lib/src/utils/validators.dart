import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  // ignore: prefer_function_declarations_over_variables
  static final requiredValidator = ({required String attribute}) =>
      MultiValidator(
          [RequiredValidator(errorText: "Campo $attribute obrigatório")]);

  // ignore: prefer_function_declarations_over_variables
  static final phoneValidator =
      ({required String attribute}) => MultiValidator([
            MinLengthValidator(14, errorText: "Número incorreto"),
          ]);

  // ignore: prefer_function_declarations_over_variables
  static final signUpNameValidator = () => MultiValidator([
        RequiredValidator(errorText: "Campo nome obrigatório"),
        MinLengthValidator(5,
            errorText: "Nome deve possuir 5 ou mais caracteres"),
        MaxLengthValidator(128, errorText: "Nome muito longo"),
      ]);

  // ignore: prefer_function_declarations_over_variables
  static final passwordValidator = () => MultiValidator([
        RequiredValidator(errorText: "Campo Senha obrigatório"),
        MinLengthValidator(8, errorText: "Senha muito curta"),
        MaxLengthValidator(128, errorText: "Senha muito longa"),
      ]);

  // ignore: prefer_function_declarations_over_variables
  static final confirmPasswordValidator = (String val1, String val2) =>
      MatchValidator(errorText: "Senhas não coincidem")
          .validateMatch(val1, val2);

  // ignore: prefer_function_declarations_over_variables
  static final emailValidator = () => MultiValidator([
        EmailValidator(errorText: "Email inválido"),
        RequiredValidator(errorText: "Campo Email obrigatório"),
      ]);
}
