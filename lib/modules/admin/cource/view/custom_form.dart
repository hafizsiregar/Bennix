import '../../../../main_library.dart';

Widget addCourceForm({error = false, onError, onChanged, TextEditingController? control, title, hint, bool isRequired = false, subtitle, maxLine, maxLength}) {
  return Container(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 4),
    color: error ? Colors.red.withOpacity(0.3) : Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '$title '),
                    TextSpan(text: isRequired ? '*' : '', style: const TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
            Text(
              maxLength != null && control != null ? '${control.text.length}/$maxLength' : '',
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
        TextFormField(
          maxLength: maxLength,
          maxLines: maxLine,
          controller: control,
          scrollPadding: EdgeInsets.zero,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: hint ?? '',
            hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            errorStyle: const TextStyle(fontSize: 0),
          ),
          onChanged: (data) {
            if (data.isNotEmpty) {
              onChanged();
            }
          },
          validator: (data) {
            if (isRequired) {
              if (data!.isEmpty) {
                error = true;
                onError();
                return 'harus Di Isi';
              }
            }
            return null;
          },
        ),
        subtitle == null
            ? const SizedBox()
            : Text(
                '($subtitle)',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8a8a8a),
                ),
              ),
      ],
    ),
  );
}
