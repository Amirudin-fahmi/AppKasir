import 'package:parfumhana_kasir/app/domain/entity/product.dart';
import 'package:parfumhana_kasir/app/presentation/product/product_notifier.dart';
import 'package:parfumhana_kasir/core/helper/global_helper.dart';
import 'package:parfumhana_kasir/core/helper/number_helper.dart';
import 'package:parfumhana_kasir/core/widget/app_widget.dart';
import 'package:parfumhana_kasir/core/widget/image_network_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductScreen extends AppWidget<ProductNotifier, void, void> {
  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(
      title: Text('Produk'),
    );
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: () => notifier.init(),
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
          height: 3,
          color: GlobalHelper.getColorScheme(context).outline,
        ),
        itemCount: notifier.listProduct.length,
        itemBuilder: (context, index) {
          final item = notifier.listProduct[index];
          return _itemLayout(context, item);
        },
      ),
    ));
  }

  _itemLayout(BuildContext context, ProductEntity item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          ImageNetworkAppWidget(
            imageUrl: item.imageUrl ?? '',
            witdh: 50,
            height: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GlobalHelper.getTextTheme(context,
                      appTextStyle: AppTextStyle.TITLE_SMALL),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  NumberHelper.formatIdr(item.price),
                  style: GlobalHelper.getTextTheme(context,
                      appTextStyle: AppTextStyle.BODY_LARGE),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stok : ${item.stock}',
                      style: GlobalHelper.getTextTheme(context,
                          appTextStyle: AppTextStyle.LABEL_MEDIUM),
                    ),
                    Text(
                      (item.isActive == 1) ? 'Active' : 'Tidak aktif',
                      style: GlobalHelper.getTextTheme(context,
                              appTextStyle: AppTextStyle.LABEL_MEDIUM)
                          ?.copyWith(
                        color:
                            (item.isActive == 1) ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
