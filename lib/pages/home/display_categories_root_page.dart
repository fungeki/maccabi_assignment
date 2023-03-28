import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maccabi_assignment/generics/layouts/error_loading.dart';
import 'package:maccabi_assignment/pages/home/display_items/display_items_details_page.dart';
import 'package:maccabi_assignment/pages/home/widgets/display_products_category_card.dart';
import 'package:maccabi_assignment/utils/constants.dart';

import '../../blocs/home/display_products_from_categories_bloc.dart';
import '../../model/products_display/products_display_category_model.dart';
import '../../utils/styles.dart';

/*Home Page:
* Displays a list of the products' categories(only one item per category).
* every item in the list is a card that consists of the name of the category,
* the thumbnail of the first item in the category,
* the total sum of different items in the category,
* and the total sum of the items in stock in the category.
* When the user presses on one of the categories,
* the app navigates to the second screen. */
class DisplayCategoriesRootPage extends StatefulWidget {
  const DisplayCategoriesRootPage({Key? key}) : super(key: key);

  @override
  State<DisplayCategoriesRootPage> createState() =>
      _DisplayCategoriesRootPageState();
}

class _DisplayCategoriesRootPageState extends State<DisplayCategoriesRootPage> {
  late DisplayProductsFromCategoriesBloc bloc;
  final ValueNotifier<List<ProductsDisplayCategoryModel>> categories =
      ValueNotifier<List<ProductsDisplayCategoryModel>>([]);

  @override
  void initState() {
    bloc = context.read<DisplayProductsFromCategoriesBloc>();
    bloc.add(FetchDataDisplayProductsFromCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose a category',
          style: Styles.kHeadlineTextStyle,
        ),
      ),
      body: BlocBuilder<DisplayProductsFromCategoriesBloc,
          DisplayProductsFromCategoriesState>(
        builder: (context, state) {
          if (state is LoadingDisplayProductsFromCategoriesState) {
            return _buildLoader();
          }
          if (state is ErrorDisplayProductsFromCategoriesState) {
            return const ErrorLoading();
          }
          if (state is OnFinishedLoadingDisplayProductsFromCategoriesState) {
            categories.value = state.categories;
          }
          return ValueListenableBuilder<List<ProductsDisplayCategoryModel>>(
              valueListenable: categories,
              builder: (context, List<ProductsDisplayCategoryModel> categories,
                  child) {
                return _buildListView(categories, height);
              });
        },
      ),
    );
  }

  ListView _buildListView(
      List<ProductsDisplayCategoryModel> categories, double height) {
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) => SizedBox(
            height: height * Constants.kCardsPerScreen,
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayItemsDetailsPage(
                      initialProducts: categories[index].products,
                      categoryIndex: index,
                    ),
                  ),
                );
                bloc.add(
                    OnProductReturnDisplayProductsFromCategoriesEvent(index));
              },
              child: DisplayProductsCategoryCard(category: categories[index]),
            )));
  }

  Center _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
