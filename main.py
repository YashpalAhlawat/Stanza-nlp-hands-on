from flask import Flask, request, jsonify
import stanza

app = Flask(__name__)


@app.route('/health', methods=['GET'])
def health():
    return jsonify("hello world!")


DEFAULT_PIPELINE = 'tokenize,pos,lemma'
DEFAULT_LANGUAGE = 'en'


# API endpoint to accept and process JSON "message" requests
@app.route('/analyze', methods=['POST'])
def analyze_text():
    try:
        # Get the input JSON data
        input_data = request.get_json()

        # Extract the message from the JSON data
        message = input_data.get('message', '')

        # Get the language and pipeline from the request or use default values
        language = input_data.get('language', DEFAULT_LANGUAGE)
        pipeline = input_data.get('pipeline', DEFAULT_PIPELINE)

        # Recreate the Stanza NLP pipeline with the specified language and processors
        nlp_pipeline = stanza.Pipeline(lang=language, processors=pipeline, use_gpu=False)

        # Process the message using the Stanza NLP pipeline
        doc = nlp_pipeline(message)

        # Get the Stanza analysis output
        analysis_output = {'tokens': [], 'pos': [], 'lemma': []}
        for sentence in doc.sentences:
            for word in sentence.words:
                analysis_output['tokens'].append(word.text)
                analysis_output['pos'].append(word.pos)
                analysis_output['lemma'].append(word.lemma)

        return jsonify(analysis_output)

    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    app.run(port=8080, debug=True)
