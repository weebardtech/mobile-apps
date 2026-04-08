import '../../../../core/storage/auth_local_storage.dart';
import '../../domain/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/profession_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;
  final AuthLocalStorage local;

  AuthRepositoryImpl(this.datasource, this.local);

  @override
  Future<List<ProfessionModel>> getProfessions() {
    return datasource.fetchProfessions();
  }

  @override
  Future<bool> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<bool> register(Map<String, dynamic> body) {
    return datasource.register(body);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await local.getToken();
    return token != null;
  }

  @override
  Future<void> logout() => local.clearToken();

  @override
  Future<void> saveToken(String token) => local.saveToken(token);
}
