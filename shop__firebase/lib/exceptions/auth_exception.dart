class AuthException with Exception {
  static const Map<String, String> keysErrors = {
    'EMAIL_EXISTS': 'Esse e-mail já existe',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Muitas tentativas realizadas',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado',
    'INVALID_PASSWORD': 'Senha inválida',
    'USER_DISABLED': 'Esse usuário está desabilitado',
    'WEAK_PASSWORD': 'Informe uma senha com pelo menos 6 caracteres',
  };

  final String key;

  const AuthException(this.key);

  @override
  String toString() {
    if (keysErrors.containsKey(key)) {
      return keysErrors[key];
    }

    return 'Ocorreu um erro';
  }
}
