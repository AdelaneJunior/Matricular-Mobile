# matricular.api.MatriculaControllerApi

## Load the API package
```dart
import 'package:matricular/api.dart';
```

All URIs are relative to *http://192.168.77.30:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**matriculaControllerAlterar**](MatriculaControllerApi.md#matriculacontrolleralterar) | **PUT** /api/v1/matricula/{id} | 
[**matriculaControllerIncluir**](MatriculaControllerApi.md#matriculacontrollerincluir) | **POST** /api/v1/matricula | 
[**matriculaControllerListAll**](MatriculaControllerApi.md#matriculacontrollerlistall) | **GET** /api/v1/matricula | 
[**matriculaControllerListAllPage**](MatriculaControllerApi.md#matriculacontrollerlistallpage) | **GET** /api/v1/matricula/page | 
[**matriculaControllerListarMatriculasListagemPorStatus**](MatriculaControllerApi.md#matriculacontrollerlistarmatriculaslistagemporstatus) | **GET** /api/v1/matricula/listar-matriculas-status | 
[**matriculaControllerObterPorId**](MatriculaControllerApi.md#matriculacontrollerobterporid) | **GET** /api/v1/matricula/{id} | 
[**matriculaControllerRemover**](MatriculaControllerApi.md#matriculacontrollerremover) | **DELETE** /api/v1/matricula/{id} | 
[**matriculaControllerSearchFieldsAction**](MatriculaControllerApi.md#matriculacontrollersearchfieldsaction) | **POST** /api/v1/matricula/search-fields | 
[**matriculaControllerSearchFieldsActionPage**](MatriculaControllerApi.md#matriculacontrollersearchfieldsactionpage) | **POST** /api/v1/matricula/search-fields/page | 
[**matriculaControllerSearchFieldsList**](MatriculaControllerApi.md#matriculacontrollersearchfieldslist) | **GET** /api/v1/matricula/search-fields | 


# **matriculaControllerAlterar**
> MatriculaDTO matriculaControllerAlterar(id, matriculaDTO)



Método utilizado para altlerar os dados de uma entidiade

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();
final int id = 789; // int | 
final MatriculaDTO matriculaDTO = ; // MatriculaDTO | 

try {
    final response = api.matriculaControllerAlterar(id, matriculaDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerAlterar: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **matriculaDTO** | [**MatriculaDTO**](MatriculaDTO.md)|  | 

### Return type

[**MatriculaDTO**](MatriculaDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **matriculaControllerIncluir**
> MatriculaDTO matriculaControllerIncluir(matriculaDTO)



Método utilizado para realizar a inclusão de um entidade

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();
final MatriculaDTO matriculaDTO = ; // MatriculaDTO | 

try {
    final response = api.matriculaControllerIncluir(matriculaDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerIncluir: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **matriculaDTO** | [**MatriculaDTO**](MatriculaDTO.md)|  | 

### Return type

[**MatriculaDTO**](MatriculaDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **matriculaControllerListAll**
> BuiltList<MatriculaDTO> matriculaControllerListAll()



Listagem Geral

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();

try {
    final response = api.matriculaControllerListAll();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerListAll: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;MatriculaDTO&gt;**](MatriculaDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **matriculaControllerListAllPage**
> PageMatriculaDTO matriculaControllerListAllPage(page)



Listagem Geral paginada

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();
final Pageable page = ; // Pageable | 

try {
    final response = api.matriculaControllerListAllPage(page);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerListAllPage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | [**Pageable**](.md)|  | 

### Return type

[**PageMatriculaDTO**](PageMatriculaDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **matriculaControllerListarMatriculasListagemPorStatus**
> BuiltList<MatriculaListagemDTO> matriculaControllerListarMatriculasListagemPorStatus(statusMatricula)



Busca a quantidade de registros

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();
final String statusMatricula = statusMatricula_example; // String | 

try {
    final response = api.matriculaControllerListarMatriculasListagemPorStatus(statusMatricula);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerListarMatriculasListagemPorStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **statusMatricula** | **String**|  | 

### Return type

[**BuiltList&lt;MatriculaListagemDTO&gt;**](MatriculaListagemDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **matriculaControllerObterPorId**
> MatriculaDTO matriculaControllerObterPorId(id)



Obter os dados completos de uma entidiade pelo id informado!

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();
final int id = 789; // int | 

try {
    final response = api.matriculaControllerObterPorId(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerObterPorId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MatriculaDTO**](MatriculaDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **matriculaControllerRemover**
> MatriculaDTO matriculaControllerRemover(id)



Método utilizado para remover uma entidiade pela id informado

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();
final int id = 789; // int | 

try {
    final response = api.matriculaControllerRemover(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerRemover: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MatriculaDTO**](MatriculaDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **matriculaControllerSearchFieldsAction**
> BuiltList<MatriculaDTO> matriculaControllerSearchFieldsAction(searchFieldValue)



Realiza a busca pelos valores dos campos informados

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();
final BuiltList<SearchFieldValue> searchFieldValue = ; // BuiltList<SearchFieldValue> | 

try {
    final response = api.matriculaControllerSearchFieldsAction(searchFieldValue);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerSearchFieldsAction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **searchFieldValue** | [**BuiltList&lt;SearchFieldValue&gt;**](SearchFieldValue.md)|  | 

### Return type

[**BuiltList&lt;MatriculaDTO&gt;**](MatriculaDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **matriculaControllerSearchFieldsActionPage**
> PageMatriculaDTO matriculaControllerSearchFieldsActionPage(searchFieldValue, page, size, sort)



Realiza a busca pelos valores dos campos informados

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();
final BuiltList<SearchFieldValue> searchFieldValue = ; // BuiltList<SearchFieldValue> | 
final int page = 56; // int | 
final int size = 56; // int | 
final BuiltList<String> sort = ; // BuiltList<String> | 

try {
    final response = api.matriculaControllerSearchFieldsActionPage(searchFieldValue, page, size, sort);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerSearchFieldsActionPage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **searchFieldValue** | [**BuiltList&lt;SearchFieldValue&gt;**](SearchFieldValue.md)|  | 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 5]
 **sort** | [**BuiltList&lt;String&gt;**](String.md)|  | [optional] [default to ListBuilder()]

### Return type

[**PageMatriculaDTO**](PageMatriculaDTO.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **matriculaControllerSearchFieldsList**
> BuiltList<SearchField> matriculaControllerSearchFieldsList()



Listagem dos campos de busca

### Example
```dart
import 'package:matricular/api.dart';

final api = Matricular().getMatriculaControllerApi();

try {
    final response = api.matriculaControllerSearchFieldsList();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MatriculaControllerApi->matriculaControllerSearchFieldsList: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;SearchField&gt;**](SearchField.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

