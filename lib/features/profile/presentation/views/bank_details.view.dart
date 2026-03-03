import 'package:flutter/material.dart';
import 'package:wink_worker/core/network/supabase_service.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _holderNameController = TextEditingController();
  final _accountController = TextEditingController();
  final _branchNameController = TextEditingController();
  final _ifscController = TextEditingController();
  bool _isFormValid = false;

  void _validateForm() {
    setState(() {
      _isFormValid =
          _bankNameController.text.trim().isNotEmpty &&
          _holderNameController.text.trim().isNotEmpty &&
          _accountController.text.trim().isNotEmpty &&
          _branchNameController.text.trim().isNotEmpty &&
          _ifscController.text.trim().isNotEmpty;
    });
  }

  final List<String> _popularBanks = [
    'State Bank of India (SBI)',
    'Punjab National Bank (PNB)',
    'Bank of Baroda (BoB)',
    'Canara Bank',
    'Union Bank of India (UBI)',
    'Indian Bank',
    'Bank of India (BoI)',
    'Central Bank of India (CBI)',
    'Indian Overseas Bank (IOB)',
    'UCO Bank',
    'Bank of Maharashtra (BoM)',
    'Punjab & Sind Bank (PSB)',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'Kotak Mahindra Bank (KMB)',
    'IndusInd Bank',
    'IDFC First Bank',
    'Federal Bank',
    'YES Bank',
    'South Indian Bank (SIB)',
    'Bandhan Bank',
    'Karur Vysya Bank (KVB)',
    'RBL Bank',
    'City Union Bank (CUB)',
    'Karnataka Bank (KBL)',
    'Tamilnad Mercantile Bank (TMB)',
    'J&K Bank',
    'Dhanlaxmi Bank',
    'Nainital Bank',
  ];

  @override
  void dispose() {
    _bankNameController.dispose();
    _holderNameController.dispose();
    _accountController.dispose();
    _branchNameController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF3F4F6),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF000D26),
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              "Bank Details",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          _buildLabel("Bank Name"),
                          const SizedBox(height: 8),
                          Autocomplete<String>(
                            optionsBuilder: (
                              TextEditingValue textEditingValue,
                            ) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }
                              return _popularBanks.where((String option) {
                                return option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase(),
                                );
                              });
                            },
                            onSelected: (String selection) {
                              _bankNameController.text = selection;
                              _validateForm();
                            },
                            fieldViewBuilder: (
                              context,
                              textEditingController,
                              focusNode,
                              onFieldSubmitted,
                            ) {
                              if (textEditingController.text !=
                                  _bankNameController.text) {
                                textEditingController.text =
                                    _bankNameController.text;
                              }
                              return _buildTextField(
                                textEditingController,
                                "Enter bank name",
                                focusNode: focusNode,
                                onChanged: (val) {
                                  _bankNameController.text = val;
                                  _validateForm();
                                },
                              );
                            },
                            optionsViewBuilder: (context, onSelected, options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4.0,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 48,
                                    constraints: const BoxConstraints(
                                      maxHeight: 200,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: options.length,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        final String option = options.elementAt(
                                          index,
                                        );
                                        return InkWell(
                                          onTap: () => onSelected(option),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              option,
                                              style: const TextStyle(
                                                color: Color(0xFF1F2937),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildLabel("Account Holder Name"),
                          const SizedBox(height: 8),
                          _buildTextField(
                            _holderNameController,
                            "Enter Account Holder Name",
                            onChanged: (_) => _validateForm(),
                          ),
                          _buildHelperText("Name as per bank records"),
                          const SizedBox(height: 20),
                          _buildLabel("Account Number"),
                          const SizedBox(height: 8),
                          _buildTextField(
                            _accountController,
                            "Enter Account Number",
                            onChanged: (_) => _validateForm(),
                          ),
                          _buildHelperText("Number as per bank records"),
                          const SizedBox(height: 20),
                          _buildLabel("Branch Name"),
                          const SizedBox(height: 8),
                          _buildTextField(
                            _branchNameController,
                            "Enter Branch Name",
                            onChanged: (_) => _validateForm(),
                          ),
                          _buildHelperText("Branch name as per bank records"),
                          const SizedBox(height: 20),
                          _buildLabel("IFSC Code"),
                          const SizedBox(height: 8),
                          _buildTextField(
                            _ifscController,
                            "Enter IFSC CODE",
                            onChanged: (_) => _validateForm(),
                          ),
                          _buildHelperText("11-character alphanumeric code"),
                          const Spacer(),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed:
                                  _isFormValid
                                      ? () {
                                        if (_formKey.currentState!.validate()) {
                                          SupabaseService().updateData({
                                            'bank_name':
                                                _bankNameController.text.trim(),
                                            'account_holder_name':
                                                _holderNameController.text
                                                    .trim(),
                                            'account_number':
                                                _accountController.text.trim(),
                                            'branch_name':
                                                _branchNameController.text
                                                    .trim(),
                                            'ifsc_code':
                                                _ifscController.text.trim(),
                                          });
                                          Navigator.pop(context, true);
                                        }
                                      }
                                      : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF000D26),
                                disabledBackgroundColor: const Color(
                                  0xFFE5E7EB,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        const Text(
          " *",
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      validator: (value) => value!.isEmpty ? "Required" : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF000D26)),
        ),
      ),
    );
  }

  Widget _buildHelperText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12),
      ),
    );
  }
}

