cmake_minimum_required(VERSION 3.2.0)
project(examples CXX)

set(BDD_LIB myBDD)
set(SRCS myBDD.cpp)
set(EXECUTABLE ${CMAKE_PROJECT_NAME}_${BDD_LIB})

find_package(${BDD_LIB} 1.0 REQUIRED)

add_executable(${EXECUTABLE} ${SRCS})

## comment in needed compiler features
set(NEEDED_FEATURES
#  cxx_template_template_parameters
#  cxx_alias_templates
#  cxx_alignas
#  cxx_alignof
#  cxx_attributes
  cxx_auto_type
#  cxx_constexpr
#  cxx_decltype
#  cxx_decltype_incomplete_return_types
#  cxx_default_function_template_args
#  cxx_defaulted_functions
#  cxx_defaulted_move_initializers
#  cxx_delegating_constructors
#  cxx_deleted_functions
#  cxx_enum_forward_declarations
#  cxx_explicit_conversions
#  cxx_extended_friend_declarations
#  cxx_extern_templates
#  cxx_final
#  cxx_func_identifier
#  cxx_generalized_initializers
#  cxx_inheriting_constructors
#  cxx_inline_namespaces
  cxx_lambdas
#  cxx_local_type_template_args
#  cxx_long_long_type
#  cxx_noexcept
#  cxx_nonstatic_member_init
#  cxx_nullptr
#  cxx_override
#  cxx_range_for
#  cxx_raw_string_literals
#  cxx_reference_qualified_functions
#  cxx_right_angle_brackets
#  cxx_rvalue_references
#  cxx_sizeof_member
#  cxx_static_assert
#  cxx_strong_enums
#  cxx_thread_local
#  cxx_trailing_return_types
#  cxx_unicode_literals
#  cxx_uniform_initialization
#  cxx_unrestricted_unions
#  cxx_user_literals
#  cxx_variadic_macros
#  cxx_variadic_templates
#  cxx_attribute_deprecated
#  cxx_binary_literals
#  cxx_contextual_conversions
#  cxx_decltype_auto
#  cxx_digit_separators
#  cxx_generic_lambdas
#  cxx_lambda_init_captures
#  cxx_return_type_deduction
)

target_compile_features(${EXECUTABLE} PRIVATE ${NEEDED_FEATURES})
target_link_libraries(${EXECUTABLE} ${BDD_LIB})

install(TARGETS ${EXECUTABLE} DESTINATION bin)
