// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/logic/cubits/cubit_exports.dart';

import 'package:stayfinder_vendor/presentation/config/image_helper.dart';
import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';
import 'package:intl/intl.dart';
import '../../data/api/api_exports.dart';
import '../../data/model/model_exports.dart';
import '../../logic/blocs/bloc_exports.dart';
import '../../logic/blocs/fetch_added_accommodations/fetch_added_accommodations_bloc.dart';
import '../../logic/cubits/store_images/store_images_cubit.dart';

class InventoryScreen extends StatefulWidget {
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dialogFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addItemFormKey = GlobalKey<FormState>();

  final updateStockController = TextEditingController();
  final itemName = TextEditingController();
  final itemCount = TextEditingController();
  final itemPrice = TextEditingController();

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  List<Widget> insAndOuts = [
    InventoryItem(
      icon: Boxicons.bx_pie_chart,
      count: "100",
      label: "Product Ins",
    ),
    InventoryItem(
      icon: Boxicons.bxs_pie_chart_alt_2,
      count: "100",
      label: "Product Outs",
    ),
    InventoryItem(
      icon: Icons.pie_chart,
      count: "100",
      label: "Total Products",
    ),
  ]
      .map((e) =>
          Padding(child: e, padding: EdgeInsets.symmetric(horizontal: 20)))
      .toList();

  List<Widget> filterOptions = [
    InkWell(
      onTap: () {},
      child: FilterItem(
        icon: Boxicons.bx_pie_chart,
        count: "Today",
      ),
    ),
    FilterItem(
      icon: Boxicons.bxs_pie_chart_alt_2,
      count: "Week",
    ),
    FilterItem(
      icon: Icons.pie_chart,
      count: "Month",
    ),
  ]
      .map((e) =>
          Padding(child: e, padding: EdgeInsets.symmetric(horizontal: 20)))
      .toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreImagesCubit(),
      child: BlocListener<AddInventoryCubit, AddInventoryState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AddInventorySuccess) {
            var loginState = context.read<LoginBloc>().state;
            if (loginState is LoginLoaded) {
              context.read<FetchInventoryCubit>()
                ..fetchInventory(
                    token: loginState.successModel.token!,
                    accommodationId: context
                        .read<StoreFilterCubit>()
                        .state
                        .accommodation!
                        .id!);
            }
            customScaffold(
                context: context,
                title: "Success",
                message: state.message,
                contentType: ContentType.success);
          }
          if (state is AddInventoryError) {
            customScaffold(
                context: context,
                title: "Error",
                message: state.message,
                contentType: ContentType.failure);
          }
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              itemName.text = "";
              itemCount.text = "";
              itemPrice.text = "";
              AddInventoryButton(context,
                  context.read<StoreFilterCubit>().state.accommodation!);
            },
            child: Icon(Icons.add),
            backgroundColor: Color(0xff37474F),
            foregroundColor: Colors.white,
          ),
          backgroundColor: Color(0xffF5F5F5),
          appBar: AppBar(
            centerTitle: true,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Color(0xff37474F),
              ),
            ),
            foregroundColor: Color(0xffF5F5F5),
            backgroundColor: Color(0xffF5F5F5),
            // backgroundColor: Color(0xff37474F),
            title: BlocBuilder<StoreFilterCubit, StoreFilterState>(
              builder: (context, state) {
                return Container(
                    padding: EdgeInsets.all(8),
                    // width: 300,w
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: [
                        Text(
                          "Filter :",
                          style: TextStyle(
                              color: Color(0xff546E7A),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DropdownButton<Accommodation>(
                            underline: SizedBox(),
                            value: state.accommodation,
                            hint: Text(state.accommodation!.name!,
                                style: TextStyle(
                                    color: Color(0xff546E7A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            onChanged: (newValue) {
                              context.read<StoreFilterCubit>()
                                ..storeAccommodation(accommodation: newValue!);
                              var loginState = context.read<LoginBloc>().state;
                              if (loginState is LoginLoaded) {
                                context.read<FetchInventoryCubit>()
                                  ..fetchInventory(
                                      token: loginState.successModel.token!,
                                      accommodationId: newValue.id!);
                              }
                            },
                            items: state.accommodationList!
                                .map<DropdownMenuItem<Accommodation>>(
                                    (Accommodation accommodation) {
                              return DropdownMenuItem<Accommodation>(
                                value: accommodation,
                                child: Text(accommodation.name!,
                                    style: TextStyle(
                                        color: Color(0xff546E7A),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)
                                    // icon: Icon(CupertinoIcons.chevron_down_circle_fill),
                                    ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ));
              },
            ),
            actions: [
              InkWell(
                  onTap: () {
                    context.read<StoreRangeDatesCubit>()..clearDates();
                    context.read<StoreSingularDateCubit>()..clearDate();
                    FilterSheet(context);
                  },
                  child: Icon(
                    Icons.settings,
                    color: Color(0xff37474F),
                  ))
            ]
                .map((e) => Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: e,
                    ))
                .toList(),
          ),
          body: BlocBuilder<FetchInventoryCubit, FetchInventoryState>(
            builder: (context, inventoryState) {
              if (inventoryState is FetchInventoryError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      inventoryState.message,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff37474F),
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: CustomMaterialButton(
                          onPressed: () {},
                          child: Text("Error"),
                          backgroundColor: Color(0xff37474F),
                          textColor: Colors.white,
                          height: 45),
                    )
                  ],
                );
              }
              if (inventoryState is FetchInventoryLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(50),
                        child: CircularProgressIndicator(
                          color: Color(0xff37474F),
                        ))
                  ],
                );
              }
              if (inventoryState is FetchInventorySuccess) {
                return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 1.1,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              InventoryItem(
                                icon: Boxicons.bx_pie_chart,
                                count: inventoryState.ins.toString(),
                                label: "Product Ins",
                              ),
                              InventoryItem(
                                icon: Boxicons.bxs_pie_chart_alt_2,
                                count: inventoryState.outs.toString(),
                                label: "Product Outs",
                              ),
                              InventoryItem(
                                icon: Icons.pie_chart,
                                count: inventoryState.total.toString(),
                                label: "Total Products",
                              ),
                            ]
                                .map((e) => InventoryStockItemsCard(child: e))
                                .toList(),
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: TabBar(
                              indicatorColor:
                                  Color(0xff455A64).withOpacity(0.3),
                              // indicator: BoxDecoration(),
                              labelColor: Color(0xff455A64),

                              dividerColor: Colors.transparent,
                              unselectedLabelColor: Color(0xffB0BEC5),
                              controller: _tabController,
                              tabs: [
                                Tab(text: "Items"),
                                Tab(text: "Logs"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (inventoryState.items.length == 0)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "You have no items",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    else
                                      GridView.builder(
                                        itemCount: inventoryState.items.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                          childAspectRatio: 3 / 4,
                                        ),
                                        physics: NeverScrollableScrollPhysics(),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          InventoryItemModel
                                              inventoryItemModel =
                                              inventoryState.items[index];

                                          return InventorItemCard(
                                              onDeleteTap: () {
                                                // print("This is deleted");
                                                showExitPopup(
                                                    context: context,
                                                    message:
                                                        "Are you sure you want to delete this ${inventoryItemModel.name}",
                                                    title: "Confirmation",
                                                    noBtnFunction: () =>
                                                        Navigator.pop(context),
                                                    yesBtnFunction: () {
                                                      var state = context
                                                          .read<LoginBloc>()
                                                          .state;
                                                      if (state
                                                          is LoginLoaded) {
                                                        context.read<
                                                            AddInventoryCubit>()
                                                          ..removeInventory(
                                                              token: state
                                                                  .successModel
                                                                  .token!,
                                                              itemId:
                                                                  inventoryItemModel
                                                                      .id!);
                                                        Navigator.pop(context);
                                                      }
                                                    });
                                              },
                                              onEditTap: () {
                                                context
                                                    .read<DropDownValueCubit>()
                                                    .instantiateDropDownValue(
                                                        items: [
                                                      'add',
                                                      'remove'
                                                    ]);
                                                context
                                                    .read<DropDownValueCubit>()
                                                    .changeDropDownValue('add');
                                                editStockDialog(context,
                                                    inventoryItemModel.id!);

                                                print("This is edited");
                                              },
                                              count: inventoryItemModel.count!,
                                              itemName:
                                                  inventoryItemModel.name!,
                                              imageUrl:
                                                  "${getIpWithoutSlash()}${inventoryItemModel.image}",
                                              date: inventoryItemModel
                                                  .date_field!,
                                              ruppees: inventoryItemModel.price
                                                  .toString());
                                        },
                                      ),
                                  ],
                                ),
                                // CoInventorItemCardlumn()
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (inventoryState.itemLogs.length == 0)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "You have no logs",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    else
                                      GridView.builder(
                                        itemCount:
                                            inventoryState.itemLogs.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                          childAspectRatio: 3 / 4,
                                        ),
                                        physics: NeverScrollableScrollPhysics(),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          InventoryLogs inventoryLogs =
                                              inventoryState.itemLogs[index];
                                          return InventoryLogCard(
                                              itemName:
                                                  inventoryLogs.item!.name!,
                                              imageUrl:
                                                  "${getIpWithoutSlash()}${inventoryLogs.item!.image!}",
                                              count: inventoryLogs.status ==
                                                      "removed"
                                                  ? "- ${inventoryLogs.count}"
                                                  : "+ ${inventoryLogs.count}",
                                              date: inventoryLogs.date_time!);
                                        },
                                      ),
                                  ],
                                ),
                              ]
                                  .map((e) => RefreshIndicator(
                                      onRefresh: () async {
                                        var loginState =
                                            context.read<LoginBloc>().state;
                                        if (loginState is LoginLoaded) {
                                          var state = context
                                              .read<
                                                  FetchAddedAccommodationsBloc>()
                                              .state;
                                          if (state
                                              is FetchAddedAccommodationsLoaded) {
                                            var items = state.accommodation;
                                            context.read<FetchInventoryCubit>()
                                              ..fetchInventory(
                                                  token: loginState
                                                      .successModel.token!,
                                                  accommodationId:
                                                      items[0].id!);
                                            await context
                                                .read<StoreFilterCubit>()
                                              ..storeAccommodation(
                                                  accommodation: items[0]);
                                            await context
                                                .read<StoreFilterCubit>()
                                              ..initializeAccommodationList(
                                                  accommodations:
                                                      state.accommodation);
                                            await context
                                                .read<StoreFilterCubit>()
                                              ..storeAccommodation(
                                                  accommodation:
                                                      state.accommodation[0]);
                                          }
                                        }
                                      },
                                      child: SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          child: e)))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ));
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> AddInventoryButton(
      BuildContext context, Accommodation accommodation) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => StoreImagesCubit(),
              ),
              BlocProvider(
                create: (context) => ImageHelperCubit()
                  ..imageHelperAccess(imageHelper: ImageHelper()),
              ),
            ],
            child: Builder(builder: (context) {
              return Form(
                key: _addItemFormKey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Add Item",
                            style: TextStyle(
                                color: Color(0xff37474F),
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          var imageHelper = context
                              .read<ImageHelperCubit>()
                              .state
                              .imageHelper!;
                          final files = await imageHelper.pickImage();
                          if (files.isNotEmpty) {
                            final croppedFile = await imageHelper.crop(
                                file: files.first,
                                cropStyle: CropStyle.rectangle);
                            print("This is cropped file //");
                            if (croppedFile != null) {
                              context.read<StoreImagesCubit>()
                                ..addImages([File(croppedFile.path)]);
                            }
                          }
                        },
                        child: BlocBuilder<StoreImagesCubit, StoreImagesState>(
                          builder: (context, state) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: (state.images.length != 0)
                                      ? null
                                      : Color(0xff37474F).withOpacity(0.5),
                                  image: (state.images.length != 0)
                                      ? DecorationImage(
                                          image: FileImage(state.images[0]))
                                      : null),
                              child: (state.images.length != 0)
                                  ? null
                                  : Icon(
                                      Icons.camera,
                                      color: Colors.white,
                                    ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                        controller: itemName,
                        validatior: (p0) {
                          if (p0 == "" || p0 == null) {
                            return "Name cannot be null";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        labelText: "Item Name",
                        onTapOutside: (p0) => FocusScope.of(context).unfocus(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: itemCount,
                        validatior: (p0) {
                          if (p0 == "" || p0 == null) {
                            return "Count cannot be null";
                          }
                          int count = int.tryParse(p0)!;
                          if (count <= 0) {
                            return "Need to add atleast One";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        labelText: "Item Count",
                        onTapOutside: (p0) => FocusScope.of(context).unfocus(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        controller: itemPrice,
                        validatior: (p0) {
                          if (p0 == "" || p0 == null) {
                            return "Price cannot be null";
                          }
                          int count = int.tryParse(p0)!;
                          if (count <= 0) {
                            return "Need to add atleast One";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        labelText: "Item Price",
                        onTapOutside: (p0) => FocusScope.of(context).unfocus(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomMaterialButton(
                          onPressed: () async {
                            if (_addItemFormKey.currentState!.validate()) {
                              if (context
                                      .read<StoreImagesCubit>()
                                      .state
                                      .images
                                      .length ==
                                  0) {
                                customScaffold(
                                    context: context,
                                    title: "Image not Found",
                                    message:
                                        "You need to provide image as well",
                                    contentType: ContentType.warning);
                                Navigator.pop(context);
                              }
                              var loginState = context.read<LoginBloc>().state;
                              if (loginState is LoginLoaded) {
                                await context.read<AddInventoryCubit>()
                                  ..addInventory(
                                      inventory: accommodation.id!,
                                      name: itemName.text,
                                      image: context
                                          .read<StoreImagesCubit>()
                                          .state
                                          .images[0],
                                      count: int.parse(itemCount.text),
                                      price: int.parse(itemPrice.text),
                                      token: loginState.successModel.token!);
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text("Confirm"),
                          backgroundColor: Color(0xff37474F),
                          textColor: Colors.white,
                          height: 45)
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Future<dynamic> editStockDialog(BuildContext context, int id) {
    updateStockController.text = 0.toString();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: false,
          actions: [],
          content: Form(
            // key: _formKey,
            key: _dialogFormKey,
            child: Container(
              height: MediaQuery.of(context).size.height / 3.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Apple Stock ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff37474F),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<DropDownValueCubit, DropDownValueState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Text(
                            "Action",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CustomDropDownButton(
                            state: context.watch<DropDownValueCubit>().state,
                            items: context
                                .read<DropDownValueCubit>()
                                .state
                                .items!
                                .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem(
                                          child: Text(value!),
                                          value: value,
                                        ))
                                .toList(),
                            onChanged: (p0) {
                              context
                                  .read<DropDownValueCubit>()
                                  .changeDropDownValue(p0!);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormField(

                      // initialValue: initialValue.toString(),
                      controller: updateStockController,
                      keyboardType: TextInputType.number,
                      onTapOutside: (p0) {
                        FocusScope.of(context).unfocus();
                      },
                      validatior: (p0) {
                        print("this is p0 ${p0}");
                        if (p0 == null || p0.isEmpty) {
                          return "Stock cannot be null";
                        }
                        if (p0 == "") {
                          return "Stock cannot be null";
                        }
                        int integerValue = int.tryParse(p0)!;
                        if (integerValue < 0) {
                          return "Stock cannot be negative";
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: CustomMaterialButton(
                            onPressed: () {
                              if (_dialogFormKey.currentState!.validate()) {
                                var loginState =
                                    context.read<LoginBloc>().state;
                                if (loginState is LoginLoaded) {
                                  context.read<AddInventoryCubit>()
                                    ..editInventory(
                                        action: context
                                            .read<DropDownValueCubit>()
                                            .state
                                            .value!,
                                        token: loginState.successModel.token!,
                                        itemId: id,
                                        count: int.parse(
                                            updateStockController.text));
                                  Navigator.pop(context);
                                }
                                print(updateStockController.text.runtimeType);
                                print("a");
                              }
                            },
                            child: Text("Update"),
                            backgroundColor: Color(0xff546E7A),
                            textColor: Colors.white,
                            height: 40),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: CustomMaterialButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"),
                            backgroundColor: Color(0xff546E7A),
                            textColor: Colors.white,
                            height: 40),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
        // return Material(
        //   child: Container(
        //     child: Row(
        //       children: [
        //         Text(
        //           "Current Stock",
        //           style: TextStyle(
        //             fontSize: 13,
        //             fontWeight: FontWeight.w400,
        //             color: Color(0xff546E7A),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         CustomFormField(
        //           inputFormatters: [
        //             FilteringTextInputFormatter
        //                 .digitsOnly
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }

  Future<dynamic> FilterSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: Color(0xffECEFF1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          height: 600,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Filter Items",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff546E7A),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 1.2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: filterOptions = [
                    InkWell(
                      onTap: () {
                        var loginState = context.read<LoginBloc>().state;
                        var storeFilter =
                            context.read<StoreFilterCubit>().state;

                        if (loginState is LoginLoaded) {
                          context.read<FetchInventoryCubit>()
                            ..fetchInventory(
                                token: loginState.successModel.token!,
                                accommodationId: storeFilter.accommodation!.id!,
                                type: 'daily');
                        }
                      },
                      child: FilterItem(
                        icon: Boxicons.bx_pie_chart,
                        count: "Today",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        var loginState = context.read<LoginBloc>().state;
                        var storeFilter =
                            context.read<StoreFilterCubit>().state;

                        if (loginState is LoginLoaded) {
                          context.read<FetchInventoryCubit>()
                            ..fetchInventory(
                                token: loginState.successModel.token!,
                                accommodationId: storeFilter.accommodation!.id!,
                                type: 'weekly');
                        }
                      },
                      child: FilterItem(
                        icon: Boxicons.bxs_pie_chart_alt_2,
                        count: "Week",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        var loginState = context.read<LoginBloc>().state;
                        var storeFilter =
                            context.read<StoreFilterCubit>().state;

                        if (loginState is LoginLoaded) {
                          context.read<FetchInventoryCubit>()
                            ..fetchInventory(
                                token: loginState.successModel.token!,
                                accommodationId: storeFilter.accommodation!.id!,
                                type: 'monthly');
                        }
                      },
                      child: FilterItem(
                        icon: Icons.pie_chart,
                        count: "Month",
                      ),
                    ),
                  ]
                      .map((e) => Padding(
                          child: e,
                          padding: EdgeInsets.symmetric(horizontal: 20)))
                      .toList()
                      .map((e) => InventoryCards(child: e))
                      .toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1,
                  height: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Filter by date",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff546E7A),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );

                      if (date != null) {
                        context.read<StoreSingularDateCubit>()
                          ..storeSingularDate(date: date.toString());
                      }
                    }, child: BlocBuilder<StoreSingularDateCubit,
                        StoreSingularDateState>(
                      builder: (context, state) {
                        return DateTimeContainer(
                            date: state.date != null
                                ? DateFormat('yyyy-MM-dd')
                                    .format(DateTime.parse(state.date!))
                                : null);
                      },
                    )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: CustomMaterialButton(
                        onPressed: () {
                          var dateState =
                              context.read<StoreSingularDateCubit>().state;
                          if (dateState.date == null || dateState.date == "") {
                            Navigator.pop(context);
                            customScaffold(
                                context: context,
                                title: "Error",
                                message: "You need to choose date first",
                                contentType: ContentType.failure);
                            return;
                          }
                          if (DateTime.parse(dateState.date!)
                              .isAfter(DateTime.now())) {
                            Navigator.pop(context);
                            customScaffold(
                                context: context,
                                title: "Error",
                                message: "You cannot view of future",
                                contentType: ContentType.failure);
                            return;
                          }
                          var loginState = context.read<LoginBloc>().state;
                          var storeFilter =
                              context.read<StoreFilterCubit>().state;

                          if (loginState is LoginLoaded) {
                            context.read<FetchInventoryCubit>()
                              ..fetchInventory(
                                  token: loginState.successModel.token!,
                                  accommodationId:
                                      storeFilter.accommodation!.id!,
                                  type: 'date',
                                  date: extractDateFromString(
                                      dateState.date.toString()));
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Filter"),
                        backgroundColor: Color(0xff78909C),
                        textColor: Colors.white,
                        height: 50,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1,
                  height: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Filter by range",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff546E7A),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );

                      if (date != null) {
                        context.read<StoreRangeDatesCubit>()
                          ..addStartDate(startDate: date.toString());
                      }
                    }, child:
                        BlocBuilder<StoreRangeDatesCubit, StoreRangeDatesState>(
                      builder: (context, state) {
                        return DateTimeContainer(
                          date: (state.startDate != null)
                              ? DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(state.startDate!))
                              : null,
                        );
                      },
                    )),
                    InkWell(onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );

                      if (date != null) {
                        context.read<StoreRangeDatesCubit>()
                          ..addEndDate(endDate: date.toString());
                      }
                    }, child:
                        BlocBuilder<StoreRangeDatesCubit, StoreRangeDatesState>(
                      builder: (context, state) {
                        return DateTimeContainer(
                          date: (state.endDate != null)
                              ? DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(state.endDate!))
                              : null,
                        );
                      },
                    ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: CustomMaterialButton(
                    onPressed: () {
                      var dateState =
                          context.read<StoreRangeDatesCubit>().state;
                      if (dateState.endDate == null ||
                          dateState.startDate == null) {
                        Navigator.pop(context);
                        customScaffold(
                            context: context,
                            title: "Error",
                            message: "Dates cannot be empty",
                            contentType: ContentType.failure);
                        return;
                      }
                      // if(Date)
                      if (DateTime.parse(dateState.startDate!)
                          .isAfter(DateTime.now())) {
                        Navigator.pop(context);
                        customScaffold(
                            context: context,
                            title: "Error",
                            message: "Start date cannot be of future",
                            contentType: ContentType.failure);
                      }
                      var loginState = context.read<LoginBloc>().state;
                      var storeFilter = context.read<StoreFilterCubit>().state;
                      if (loginState is LoginLoaded) {
                        context.read<FetchInventoryCubit>()
                          ..fetchInventory(
                              token: loginState.successModel.token!,
                              accommodationId: storeFilter.accommodation!.id!,
                              type: 'range',
                              endDate: extractDateFromString(
                                  dateState.endDate.toString()),
                              date: extractDateFromString(
                                  dateState.startDate.toString()));

                        Navigator.pop(context);
                      }
                    },
                    child: Text("Filter"),
                    backgroundColor: Color(0xff78909C),
                    textColor: Colors.white,
                    height: 45,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class InventorItemCard extends StatelessWidget {
  final Function()? onDeleteTap;
  final Function()? onEditTap;

  final int count;
  final String itemName;
  final String imageUrl;
  final String date;
  final String ruppees;

  // final
  InventorItemCard({
    Key? key,
    this.onDeleteTap,
    this.onEditTap,
    required this.count,
    required this.itemName,
    required this.imageUrl,
    required this.date,
    required this.ruppees,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    130,
                  ),
                  bottomLeft: Radius.circular(
                    15,
                  ),
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15)), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Slightly darker shadow
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text("${itemName} ( $count )",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff546E7A),
                                    fontWeight: FontWeight.w500)),
                            SizedBox(height: 5),
                            Text("Rs ${ruppees}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff546E7A),
                                    fontWeight: FontWeight.w500)),
                            Text("Added: ${formatDateTimeinMMMMDDYYY(date)}",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff546E7A),
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onDeleteTap,
                      child: Container(
                        width: 42.93,
                        height: 32.31,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(150)),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: onEditTap,
                      child: Container(
                        width: 42.93,
                        height: 32.31,
                        decoration: BoxDecoration(
                            color: Color(0xff37474F),
                            borderRadius: BorderRadius.circular(150)),
                        child: Icon(
                          Icons.edit_note_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                )
                // InventoryItemLogCard(
                //     icon: Icons.apartment,
                //     name: "Appleddadasdafjshajdajdda",
                //     action: "-1",
                //     date: date,
                //     time: date)
              ],
            ),
            // alignment: ,
          ),
          Positioned(
            right: 1,
            top: -1,
            child: Container(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(100)),
                      );
                    },
                    imageUrl: imageUrl)),
            //  Container(
            //   width: 100,
            //   height: 100,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/images/sample_photo.png')),
            //     borderRadius: BorderRadius.circular(100)),)
          ),
        ],
      ),
    );
  }
}

class InventoryLogCard extends StatelessWidget {
  final String count;
  final String itemName;
  final String imageUrl;
  final String date;
  InventoryLogCard({
    Key? key,
    required this.count,
    required this.itemName,
    required this.date,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    130,
                  ),
                  bottomLeft: Radius.circular(
                    15,
                  ),
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15)), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Slightly darker shadow
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                InventoryItemLogCard(
                    icon: Icons.apartment,
                    name: itemName,
                    action: count,
                    date: date,
                    time: date)
              ],
            ),
            // alignment: ,
          ),
          Positioned(
            right: 1,
            top: -1,
            child: Container(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(100)),
                      );
                    },
                    imageUrl: imageUrl)),
            //  Container(
            //   width: 100,
            //   height: 100,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/images/sample_photo.png')),
            //     borderRadius: BorderRadius.circular(100)),)
          ),
        ],
      ),
    );
  }
}

class DateTimeContainer extends StatelessWidget {
  String? date;
  DateTimeContainer({
    String? this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: MainAxisAlignment.ce,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Slightly darker shadow
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width / 2.5,
      height: 50,
      child: Text(
        date == null ? 'DD / MM / YYYY' : date!,
        style: TextStyle(
            color: date == null ? Color(0xff78909C) : Color(0xff37474F),
            fontWeight: FontWeight.w600,
            fontSize: 12),
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  final IconData icon;
  final String count;

  FilterItem({
    Key? key,
    required this.icon,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Color(0xff78909C)),
        SizedBox(height: 10),
        Text(count,
            style: TextStyle(
                fontSize: 12,
                color: Color(0xff546E7A),
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class InventoryItemLogCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String action;
  final String date;
  final String time;

  InventoryItemLogCard({
    Key? key,
    required this.icon,
    required this.name,
    required this.action,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(name,
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff546E7A),
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                Text("Count: ${action}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff546E7A),
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 10,
                ),
                Text(formatDateTimeinMMMMDDYYY(date),
                    style: TextStyle(
                        fontSize: 10,
                        color: Color(0xff546E7A),
                        fontWeight: FontWeight.w300)),
                Text(formatIntoTimeAmPm(date),
                    style: TextStyle(
                        fontSize: 10,
                        color: Color(0xff546E7A),
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InventoryItem extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;

  const InventoryItem({
    Key? key,
    required this.icon,
    required this.count,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Color(0xff78909C),
            size: 14,
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(count,
                  style: TextStyle(
                      fontSize: 11,
                      color: Color(0xff546E7A),
                      fontWeight: FontWeight.w400)),
              SizedBox(
                width: 10,
              ),
              Text(label,
                  style: TextStyle(
                      fontSize: 11,
                      color: Color(0xff546E7A),
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ],
      ),
    );
  }
}

class InventoryStockItemsCard extends StatelessWidget {
  final Widget child;
  InventoryStockItemsCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8), // Added padding for inner spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Slightly darker shadow
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: child,
    );
  }
}

class InventoryCards extends StatelessWidget {
  final Widget child;
  InventoryCards({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8), // Added padding for inner spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Slightly darker shadow
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: child,
    );
  }
}
