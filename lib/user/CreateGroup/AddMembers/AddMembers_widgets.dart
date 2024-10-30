import 'package:flutter/material.dart';
import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:get/get.dart';

class AddMembers_widgets {

  static Widget searchBar(TextEditingController searchController, Function onSearch) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: TextField(
        controller: searchController,
        onChanged: (_) => onSearch(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color_.gray),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color_.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  static Widget userList(List<String> itemsToShow, List<String> selectedItems, Function toggleSelection) {
    return itemsToShow.isNotEmpty
        ? ListView.builder(
      itemCount: itemsToShow.length,
      itemBuilder: (context, index) {
        String item = itemsToShow[index];
        bool isSelected = selectedItems.contains(item);
        return ListTile(
          title: Text(item, style: TextStyle(color: color_.black)),
          trailing: GestureDetector(
            onTap: () => toggleSelection(item),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color_.black : color_.gray,
                  width: 2,
                ),
                color: isSelected ? color_.black : Colors.white30,
              ),
              child: isSelected
                  ? Icon(Icons.check, color: color_.white)
                  : null,
            ),
          ),
        );
      },
    )
        : Center(child: Text("No results found"));
  }

  static Widget addButton(Function onAddPressed, bool hasSelectedItems) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, bottom: 20),
        child: ElevatedButton(
          onPressed: () => onAddPressed(),
          child: Text("Add", style: TextStyle(color: color_.white, fontSize: 16)),
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            backgroundColor: hasSelectedItems ? color_.black : color_.gray,
          ),
        ),
      ),
    );
  }
}
