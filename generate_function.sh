#!/bin/bash

# Function to add a function to a Dart file
add_function_to_file() {
  local file_path=$1
  local function_name=$2

  echo "Adding function '$function_name' to $file_path..."

  # Check if the file already contains the function
  if grep -q "Future<BaseResponse<.*>> $function_name" "$file_path"; then
    echo "Error: Function '$function_name' already exists in $file_path."
    return
  fi

  # Add the function to the bottom of the class
  case "$file_path" in
    *i_repository.dart)
      sed -i '' "/^}/i\\
  Future<BaseResponse<bool>> $function_name({required Map<String, dynamic> req});\\
" "$file_path"
      ;;
    *repository.dart)
      sed -i '' "/^}/i\\
  @override\\
  Future<BaseResponse<bool>> $function_name({required Map<String, dynamic> req}) {\\
    return _service.$function_name(req: req);\\
  }\\
" "$file_path"
      ;;
    *service.dart)
      sed -i '' "/^}/i\\
  Future<BaseResponse<bool>> $function_name({required Map<String, dynamic> req}) {\\
    return DioClient.postMethod(\\
      path: '/new/endpoint/path',\\
      request: req,\\
      parseData: (json) => true,\\
    );\\
  }\\
" "$file_path"
      ;;
    *)
      echo "Error: Unsupported file $file_path."
      ;;
  esac
}

# Prompt for the function name
read -p "Enter the name of the function to generate: " function_name

# List of files to update
files=(
  "/Users/metamartin/Documents/Project/dv_pay_mobile/lib/src/core/data/repository/i_repository.dart"
  "/Users/metamartin/Documents/Project/dv_pay_mobile/lib/src/core/data/repository/repository.dart"
  "/Users/metamartin/Documents/Project/dv_pay_mobile/lib/src/core/data/repository/service.dart"
)

# Add the function to each file
for file in "${files[@]}"; do
  add_function_to_file "$file" "$function_name"
done

echo "Function generation completed."
