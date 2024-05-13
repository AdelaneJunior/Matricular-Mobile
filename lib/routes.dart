import 'package:routefly/routefly.dart';

import 'app/home/home_page.dart' as a0;
import 'app/login/login_page.dart' as a1;
import 'app/matriculas/matriculas_page.dart' as a2;
import 'app/necessidades/insert/necessidade_insert_page.dart' as a3;
import 'app/necessidades/necessidades_page.dart' as a4;
import 'app/prefs/prefs_page.dart' as a5;
import 'app/recuperar_senha/recuperar_senha_page.dart' as a6;

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/home',
    uri: Uri.parse('/home'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a0.HomePage(),
    ),
  ),
  RouteEntity(
    key: '/login',
    uri: Uri.parse('/login'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a1.LoginPage(),
    ),
  ),
  RouteEntity(
    key: '/matriculas',
    uri: Uri.parse('/matriculas'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a2.MatriculaPage(),
    ),
  ),
  RouteEntity(
    key: '/necessidades/insert/necessidade_insert',
    uri: Uri.parse('/necessidades/insert/necessidade_insert'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a3.NecessidadeInsertPage(),
    ),
  ),
  RouteEntity(
    key: '/necessidades',
    uri: Uri.parse('/necessidades'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a4.NecessidadePage(),
    ),
  ),
  RouteEntity(
    key: '/prefs',
    uri: Uri.parse('/prefs'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a5.PrefsPage(),
    ),
  ),
  RouteEntity(
    key: '/recuperar_senha',
    uri: Uri.parse('/recuperar_senha'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a6.RecuperarSenha(),
    ),
  ),
];

const routePaths = (
  path: '/',
  home: '/home',
  login: '/login',
  matriculas: '/matriculas',
  necessidades: (
    path: '/necessidades',
    insert: (
      path: '/necessidades/insert',
      necessidadeInsert: '/necessidades/insert/necessidade_insert',
    ),
  ),
  prefs: '/prefs',
  recuperarSenha: '/recuperar_senha',
);
