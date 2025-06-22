import os
from mistralai import Mistral
import sys
from datasets import load_dataset
from sklearn.metrics.pairwise import euclidean_distances

api_key = os.environ["MISTRAL_API_KEY"]
model = "codestral-embed"

client = Mistral(api_key=api_key)

embeddings_batch_response = client.embeddings.create(
    model=model,
    # output_dtype="binary",
    output_dimension=512,
    inputs=[
        "Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target. You may assume that each input would have exactly one solution, and you may not use the same element twice. You can return the answer in any order. Example 1: Input: nums = [2,7,11,15], target = 9 Output: [0,1] Explanation: Because nums[0] + nums[1] == 9, we return [0, 1]. Example 2: Input: nums = [3,2,4], target = 6 Output: [1,2] Example 3: Input: nums = [3,3], target = 6 Output: [0,1] Constraints: 2 <= nums.length <= 104 -109 <= nums[i] <= 109 -109 <= target <= 109 Only one valid answer exists.",
        "class Solution: def twoSum(self, nums: List[int], target: int) -> List[int]: d = {} for i, x in enumerate(nums): if (y := target - x) in d: return [d[y], i] d[x] = i",
    ],
)


def get_code_embedding(inputs):
    embeddings_batch_response = client.embeddings.create(model=model, inputs=inputs)
    return embeddings_batch_response.data[0].embedding


def remove_whitespace(code):
    return code.replace("\n", "").replace("\t", "").replace(" ", "")

def main():
    args = sys.argv[1]
    code = args
    print(remove_whitespace(code))

if __name__ == "__main__":
    main()
