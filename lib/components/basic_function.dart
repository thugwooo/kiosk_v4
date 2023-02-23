dynamic str_to_list(str_data) {
  if (str_data.runtimeType != String) {
    return str_data;
  }
  var temp;
  temp = str_data.replaceAll('[', '').replaceAll(']', '').replaceAll("'", '').split(', ');
  for (var index = 0; index < temp.length; index++) {
    if (temp[index] == '') {
      temp.remove('');
    } else {
      print(temp);
      temp[index] = temp[index].trim();
    }
  }
  return temp;
}

dynamic list_to_str(list_data) {
  if (list_data.runtimeType == String) {
    return list_data;
  }
  var temp = list_data;
  if (list_data == null) {
    return '';
  }
  for (var index = 0; index < temp.length; index++) {
    if (temp[index] == '') {
      temp.remove('');
    }
  }
  return temp.toString().replaceAll('[', '').replaceAll(']', '').replaceAll('  ', ' ').replaceAll('  ', ' ');
}
